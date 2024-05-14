import os
import time
import string
import logging
import argparse
from queue import Queue
from threading import Thread, Event

import numpy as np
import cv2

logger = logging.getLogger(__name__)


class Sensor:
    def get(self):
        raise NotImplementedError("Subclasses must implement method get()")


class SensorX(Sensor):
    """Sensor X"""

    def __init__(self, delay: float):
        self._delay = delay
        self._data = 0

    def get(self) -> int:
        time.sleep(self._delay)
        self._data += 1
        return self._data


class SensorCam(Sensor):
    """Sensor Cam"""

    def __init__(self, name: string, width: int, height: int):
        self._name = name
        self._width = width
        self._height = height
        self._camera = cv2.VideoCapture(self._name)
        if not self._camera.isOpened():
            self._camera.release()
            logger.error("Camera not found, accessing VideoCapture(0)")
            self._camera = cv2.VideoCapture(0)
            if not self._camera.isOpened():
                self._camera.release()
                logger.critical("Camera not found, terminating")
                exit(1)

    def get(self) -> np.ndarray:
        ret, frame = self._camera.read()
        if not ret:
            logger.error("Failed to get frame, accessing VideoCapture(name)")
            self._camera = cv2.VideoCapture(self._name)
            if not self._camera.isOpened():
                logger.error("Camera not found, accessing VideoCapture(0)")
                self._camera = cv2.VideoCapture(0)
                if not self._camera.isOpened():
                    self._camera.release()
                    logger.critical("Camera not found, terminating")
                    exit(1)

        resized_frame = cv2.resize(frame, (self._width, self._height))
        return resized_frame

    def __del__(self):
        self._camera.release()


class WindowImage:
    def __init__(self, frames_per_second):
        self._frames_per_second = frames_per_second

    def show(self, img: np.ndarray):
        cv2.imshow("Image", img)
        time.sleep(1 / self._frames_per_second)

    def __del__(self):
        cv2.destroyWindow("Image")


def sensor_x_work(stop_event: Event, delay: float, queue: Queue):
    sensor = SensorX(delay)
    while not stop_event.wait(0.0001):
        queue.put(sensor.get())


def sensor_cam_work(stop_event: Event, name: string, width: int, height: int, queue: Queue):
    sensor = SensorCam(name, width, height)
    while not stop_event.wait(0.0001):
        queue.put(sensor.get())


if __name__ == "__main__":
    os.makedirs("log", exist_ok=True)
    logging.basicConfig(filename="log/log.txt", level=logging.ERROR)

    window_image = WindowImage(30)

    stop_event = Event()

    sensor0_queue = Queue()
    sensor0_thread = Thread(target=sensor_x_work, args=(stop_event, 0.01, sensor0_queue))
    sensor1_queue = Queue()
    sensor1_thread = Thread(target=sensor_x_work, args=(stop_event, 0.1, sensor1_queue))
    sensor2_queue = Queue()
    sensor2_thread = Thread(target=sensor_x_work, args=(stop_event, 1, sensor2_queue))
    sensor_cam_queue = Queue()
    sensor_cam_thread = Thread(target=sensor_cam_queue, args=(stop_event, cam_name, cam_width, cam_height, sensor_cam_queue))


