
CC := g++

DIR_BIN := bin
DIR_SRC := src
DIR_GLAD := glad

DIRS := $(DIR_BIN)
EXECUTABLES := $(patsubst %.cpp,$(DIR_BIN)/%,$(notdir $(wildcard $(DIR_SRC)/*.cpp)))

CFLAGS += -Wall -Werror

INCLUDES := -Iglad/include

all: $(EXECUTABLES)

$(EXECUTABLES) : glad/src/glad.c | $(DIRS) $(DIR_GLAD)

$(DIR_BIN)/% : $(DIR_SRC)/%.cpp
	$(CC) $(CFLAGS) `pkg-config --cflags glfw3` -o $@ $^ $(INCLUDES) `pkg-config --static --libs glfw3`

%/glad.c :
	glad --generator=c --out-path=glad

$(DIRS):
	mkdir -p $@
