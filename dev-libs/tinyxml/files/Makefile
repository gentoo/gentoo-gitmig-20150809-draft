AR ?= ar
CXX ?= g++
CXXFLAGS += -Wall
RANLIB ?= ranlib

name = libtinyxml
major = 0
minor = 0.0
version = $(major).$(minor)

src = tinystr.cpp tinyxml.cpp tinyxmlerror.cpp tinyxmlparser.cpp
lo = $(addsuffix .lo,$(basename ${src}))
o = $(addsuffix .o,$(basename ${src}))

all: $(name).a $(name).so

%.o: %.cpp
	$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) $< -o $@

$(name).a: $(o)
	$(AR) rc $(name).a $(o)
	$(RANLIB) $(name).a

%.lo: %.cpp
	$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) -fPIC $< -o $@

$(name).so: $(lo)
	$(CXX) $(LDFLAGS) -fPIC -shared $(lo) -Wl,-soname,$(name).so.$(major) -o $(name).so.$(version)
	ln -s $(name).so.$(version) $(name).so.$(major)
	ln -s $(name).so.$(version) $(name).so

clean:
	-rm -f *.o *.lo *.so* *.a
