#
# Standard directory locations for UNIX (no configure script as yet)
#

ifneq ($(OSTYPE),windows)
	OSTYPE := $(shell uname -s)
	bindir = /usr/local/games
	sharedir = /usr/local/share/tworld
	mandir = /usr/local/man
endif


OSHW ?= oshw-qt


COMMONFLAGS = -Wall -I. -DNDEBUG
LINK = $(CC)
ifeq ($(OSTYPE),windows)
	EXE  = .exe
	RM_F = del /f
	CP   = copy
	CC   = gcc
	CXX  = g++
else ifeq ($(OSTYPE),Darwin)
	CC   = gcc-4.9 -g
	CXX  = g++-4.9 -g
	COMMONFLAGS = -Wall -I.
	EXE  =
	RM_F = rm -f
	CP   = cp
else
	EXE  =
	RM_F = rm -f
	CP   = cp
endif



ifneq ($(OSTYPE),windows)
	COMMONFLAGS += '-DROOTDIR="$(sharedir)"'
endif
ifneq ($(findstring qt,$(OSHW)),)
	COMMONFLAGS += -D__TWPLUSPLUS
endif

CFLAGS += $(COMMONFLAGS)
CXXFLAGS += $(COMMONFLAGS)

%.o: %.c
	@echo Compiling $<...
	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -o $@ $<

%.o: %.cpp
	@echo Compiling $<...
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -o $@ $<
