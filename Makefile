
CC := g++

DIR_BIN := bin
DIR_SRC := src
DIR_GLAD := glad
DIR_GLM := glm

DIRS := $(DIR_BIN)
EXECUTABLES := $(patsubst %.cpp,$(DIR_BIN)/%,$(notdir $(wildcard $(DIR_SRC)/*.cpp)))

CFLAGS += -Wall -Werror -std=c++11
IGNORE_WARN := -Wno-comment
CFLAGS += $(IGNORE_WARN)

INCLUDES := -Iglad/include -Iinclude -Iglm

all: $(EXECUTABLES)

$(EXECUTABLES) : glad/src/glad.c | $(DIRS) $(DIR_GLAD) $(DIR_GLM)

$(DIR_BIN)/% : $(DIR_SRC)/%.cpp
	$(CC) $(CFLAGS) `pkg-config --cflags glfw3` -o $@ $^ $(INCLUDES) `pkg-config --static --libs glfw3`

%/glad.c :
	glad --generator=c --out-path=glad

$(DIR_GLM):
	git clone https://github.com/g-truc/glm
	cd $@ && git checkout 0.9.9.3

$(DIRS):
	mkdir -p $@
