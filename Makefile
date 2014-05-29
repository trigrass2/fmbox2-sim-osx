
SOURCE = \
	src/http_client.cpp \
	src/main.cpp \
	src/ui_glut.cpp \
	src/ui_pixbuf.cpp \
	src/utils.cpp \
	src/xiami_index_json_html.cpp \
	src/xiami_login.cpp \
	src/xiami_playlist_xml.cpp \

SOURCE = src/main.cpp src/http.cpp src/xml.cpp

CCFLAGS = \
	-I/usr/local/opt/libxml2/include/libxml2 -I. \
	-Wno-deprecated-writable-strings

LDFLAGS = \
	-L/usr/local/opt/libxml2/lib \
	-framework OpenGL -framework GLUT -framework Foundation \
	-lxml2 -luv -ljpeg -ljson-c -lhttp_parser

OBJS = $(patsubst %.cpp,%.o,${SOURCE})

all: fmbox

src/fmbox2.h: src/http.h src/utils.h src/xml.h

${OBJS}: src/fmbox2.h

%.o: %.cpp
	c++ ${CCFLAGS} -c -o $@ $<

fmbox: ${OBJS}
	${CC} ${OBJS} ${LDFLAGS} -o $@

bison-test:

clean: 
	rm -rf src/*.o fmbox

dep:
	sudo brew install libxml2 json-c

