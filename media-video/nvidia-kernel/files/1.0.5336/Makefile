# This Makefile is automatically generated; do not edit
#   Generated on 'builder3.nvidia.com' on Thu Jun 19 04:05:35 PDT 2003

LINUX_MODULE=nv-linux.o
DEFINES=-D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -DKBUILD_MODNAME="nvidia" -DNTRM -D_GNU_SOURCE -D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE  -DNV_MAJOR_VERSION=1 -DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=5328     -DNV_UNIX   -DNV_LINUX   -DNV_INT64_OK   -DNVCPU_X86
INCLUDES=-I.

OBJECTS=nv.o os-agp.o os-interface.o os-registry.o 
HEADERS=os-agp.h os-interface.h nv-linux.h nv-misc.h nv-memdbg.h nv.h  rmretval.h nvtypes.h  $(VERSION_HDR)

CFLAGS=-Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts -Wparentheses -Wcast-qual -Wno-multichar  -O -MD $(DEFINES) $(INCLUDES) -Wno-cast-qual

RESMAN_KERNEL_MODULE=nv-kernel.o

KERNDIR=/lib/modules/$(shell uname -r)

# check for newer paths. if found, use them, otherwise use old paths
# these wouldn't work with the gnu make included with rh6.2
# KERNINC=$(if -d $(KERNDIR)/build, $(KERNDIR)/build/include, /usr/src/linux/include)
# INSTALLDIR=$(if -d $(KERNDIR)/kernel, $(KERNDIR)/kernel/drivers/video, $(KERNDIR)/video)

# this is slightly more brain-dead, but works..
ifeq ($(shell if test -d $(KERNDIR)/build; then echo yes; fi),yes)
KERNINC=$(KERNDIR)/build/include
else
KERNINC=/usr/src/linux/include
endif

ifeq ($(shell if test -d $(KERNDIR)/kernel; then echo yes; fi),yes)
INSTALLDIR=$(KERNDIR)/kernel/drivers/video
else
INSTALLDIR=$(KERNDIR)/video
endif

ifeq ($(shell echo $(NVDEBUG)),1)
  ifeq ($(shell test -z $(RMDEBUG) && echo yes),yes)
    RMDEBUG=1
  endif
endif

ifeq ($(shell echo $(RMDEBUG)),1)
CFLAGS += -DDEBUG -g -fno-common
endif

# this is just plain wrong, get rid of it
BROKENDIR=$(KERNDIR)/kernel/video

INSTALL=$(shell which install)

# allow specification of alternate include file tree on command line and extra defines
ifdef SYSINCLUDE
INCLUDES += -I$(SYSINCLUDE)
INCLUDES += -I$(SYSINCLUDE)/asm/mach-default
else
INCLUDES += -I$(KERNINC)
INCLUDES += -I$(KERNINC)/asm/mach-default
endif

ifeq ($(shell sh conftest.sh remap_page_range $(INCLUDES)), 5)
  DEFINES += -DREMAP_PAGE_RANGE_5
endif

ifeq ($(shell sh conftest.sh remap_page_range $(INCLUDES)), 4)
  DEFINES += -DREMAP_PAGE_RANGE_4
endif

ifeq ($(shell sh conftest.sh class_simple $(INCLUDES)), yes)
  DEFINES += -DHAVE_CLASS_SIMPLE
endif

DEFINES+=$(EXTRA_DEFINES)

# allow build parameters to be passed in through the environment
ifdef BUILD_PARAMS
    DEFINES+=-D$(BUILD_PARAMS)
endif

VERSION_HDR=nv_compiler.h

all: install

install: package-install

suser-sanity-check:
	@if ! sh conftest.sh suser_sanity_check; then \
	  echo; \
	  echo "You have insufficient privileges for this operation. Please "; \
	  echo "run \"make install\" as root!                               "; \
	  echo; \
	  exit 1; \
	fi

rmmod-sanity-check:
	@if ! sh conftest.sh rmmod_sanity_check nvidia; then \
	  echo; \
	  echo "Unable to unload the currently loaded NVIDIA kernel module! "; \
	  echo "Please be certain that you have exited X before attempting  "; \
	  echo "to install this version.                                    "; \
	  echo; \
	  exit 1; \
	fi

cc-sanity-check:
	@if ! sh conftest.sh cc_sanity_check full_output $(CC); then exit 1; fi

package-install: suser-sanity-check nvidia.o rmmod-sanity-check
	if [ -d $(BROKENDIR) ]; then \
		rm -f $(BROKENDIR)/NVdriver; \
		rmdir --ignore-fail-on-non-empty $(BROKENDIR); \
	fi && \
	mkdir -p $(INSTALLDIR) && \
	rm -f $(INSTALLDIR)/NVdriver && \
	$(INSTALL) -m 0664 -o root -g root nvidia.o $(INSTALLDIR)/nvidia.o$(O) && \
	/sbin/depmod -a && \
	/sbin/modprobe nvidia && \
	sh makedevices.sh && \
	echo "nvidia.o installed successfully."; \

nvidia.o: cc-sanity-check $(LINUX_MODULE) $(RESMAN_KERNEL_MODULE) 
	ld -d -r -o $@ $(LINUX_MODULE) $(RESMAN_KERNEL_MODULE)

$(VERSION_HDR): 
	echo \#define NV_COMPILER \"`$(CC) -v 2>&1 | tail -n 1`\" > $@

$(LINUX_MODULE): $(OBJECTS)
	ld -r -o $@ $(OBJECTS)

%.o: %.c $(HEADERS)
	$(CC) -c $(CFLAGS) $<

# debug tool to preprocess the file and leave .i to make it easier to untangle #defines
%.i: %.c
	$(CC) $(CFLAGS) -E $< > $@

%.s: %.c
	$(CC) $(CFLAGS) -S $< > $@


clean:
	$(RM) $(OBJECTS) $(LINUX_MODULE) $(VERSION_HDR) *.d NVdriver nvidia.o


-include $(OBJECTS:%.o=%.d)
