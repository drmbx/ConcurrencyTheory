# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/i.purtov/task2/2.3

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/i.purtov/task2/2.3/build

# Include any dependencies generated for this target.
include CMakeFiles/individual_region.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/individual_region.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/individual_region.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/individual_region.dir/flags.make

CMakeFiles/individual_region.dir/source/individual_region.cpp.o: CMakeFiles/individual_region.dir/flags.make
CMakeFiles/individual_region.dir/source/individual_region.cpp.o: ../source/individual_region.cpp
CMakeFiles/individual_region.dir/source/individual_region.cpp.o: CMakeFiles/individual_region.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/i.purtov/task2/2.3/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/individual_region.dir/source/individual_region.cpp.o"
	/opt/nvidia/hpc_sdk/Linux_x86_64/23.11/compilers/bin/nvc++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/individual_region.dir/source/individual_region.cpp.o -MF CMakeFiles/individual_region.dir/source/individual_region.cpp.o.d -o CMakeFiles/individual_region.dir/source/individual_region.cpp.o -c /home/i.purtov/task2/2.3/source/individual_region.cpp

CMakeFiles/individual_region.dir/source/individual_region.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/individual_region.dir/source/individual_region.cpp.i"
	/opt/nvidia/hpc_sdk/Linux_x86_64/23.11/compilers/bin/nvc++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/i.purtov/task2/2.3/source/individual_region.cpp > CMakeFiles/individual_region.dir/source/individual_region.cpp.i

CMakeFiles/individual_region.dir/source/individual_region.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/individual_region.dir/source/individual_region.cpp.s"
	/opt/nvidia/hpc_sdk/Linux_x86_64/23.11/compilers/bin/nvc++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/i.purtov/task2/2.3/source/individual_region.cpp -o CMakeFiles/individual_region.dir/source/individual_region.cpp.s

# Object files for target individual_region
individual_region_OBJECTS = \
"CMakeFiles/individual_region.dir/source/individual_region.cpp.o"

# External object files for target individual_region
individual_region_EXTERNAL_OBJECTS =

individual_region: CMakeFiles/individual_region.dir/source/individual_region.cpp.o
individual_region: CMakeFiles/individual_region.dir/build.make
individual_region: CMakeFiles/individual_region.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/i.purtov/task2/2.3/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable individual_region"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/individual_region.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/individual_region.dir/build: individual_region
.PHONY : CMakeFiles/individual_region.dir/build

CMakeFiles/individual_region.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/individual_region.dir/cmake_clean.cmake
.PHONY : CMakeFiles/individual_region.dir/clean

CMakeFiles/individual_region.dir/depend:
	cd /home/i.purtov/task2/2.3/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/i.purtov/task2/2.3 /home/i.purtov/task2/2.3 /home/i.purtov/task2/2.3/build /home/i.purtov/task2/2.3/build /home/i.purtov/task2/2.3/build/CMakeFiles/individual_region.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/individual_region.dir/depend

