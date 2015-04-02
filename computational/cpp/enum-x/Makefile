NAME := enum-x
SRCS := $(wildcard *.cpp)
OBJS := $(SRCS:.cpp=.o)

# add to INCLUDE_DIRS the include directories in which gmp.h and libflint headers are located, respecitively, e.g., /opt/local/include and /usr/local/include/flint
INCLUDE_DIRS := /Users/zmwang/include/flint /opt/local/include
# add to LIBRARY_DIRS the lib directories in which libgmp libflint are located, respectively, e.g., /opt/local/lib and /usr/local/lib
LIBRARY_DIRS := /Users/zmwang/lib /opt/local/lib
LIBRARIES := gmp flint

CXXFLAGS += -g -O2

CPPFLAGS += $(foreach includedir,$(INCLUDE_DIRS),-I$(includedir))
LDFLAGS += $(foreach librarydir,$(LIBRARY_DIRS),-L$(librarydir))
LDFLAGS += $(foreach library,$(LIBRARIES),-l$(library))

CXXFLAGS += -pedantic -Werror -Wall -Wextra -Wno-unused-parameter
LDFLAGS += -fno-common

.PHONY: all clean distclean

all: $(NAME)

$(NAME): $(OBJS)
	$(LINK.cc) $(OBJS) -o $(NAME)

clean:
	@- $(RM) $(NAME)
	@- $(RM) $(OBJS)
	@- $(RM) make.log

distclean: clean
