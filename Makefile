PLATFORM ?= PLATFORM_DESKTOP
BUILD_MODE ?= RELEASE

RAYLIB_DIR = raylib
INCLUDE_DIR = -I ./ -I $(RAYLIB_DIR)/include
LIBRARY_DIR = -L $(RAYLIB_DIR)/lib
DEFINES = -D _DEFAULT_SOURCE -D RAYLIB_BUILD_MODE=$(BUILD_MODE) -D $(PLATFORM) -D _CRT_SECURE_NO_DEPRECATE

ifeq ($(PLATFORM),PLATFORM_DESKTOP)
    CC = clang++
    EXT = .exe
    ifeq ($(BUILD_MODE),RELEASE)
        CFLAGS ?= $(DEFINES) -ffast-math -march=native -D NDEBUG -O3  $(INCLUDE_DIR) $(LIBRARY_DIR)
	else
        CFLAGS ?= $(DEFINES) -g $(INCLUDE_DIR) $(LIBRARY_DIR)
	endif
    LIBS = -lraylib -lopengl32 -lgdi32 -lwinmm -lmsvcrt -lUser32 -lShell32 -lAdvapi32
endif


SOURCE = $(wildcard *.cpp)
HEADER = $(wildcard *.h)

.PHONY: all

all: controller

controller: $(SOURCE) $(HEADER)
	$(CC) -o $@$(EXT) $(SOURCE) $(CFLAGS) $(LIBS) -fuse-ld=lld

clean:
	rm controller$(EXT)