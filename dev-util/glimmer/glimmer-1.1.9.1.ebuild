# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tod M. Neidt <tneidt@fidnet.com>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

A=glimmer-1.1.9-1.tar.gz
S=${WORKDIR}/glimmer-1.1.9-1
DESCRIPTION="All-purpose gnome code editor."
SRC_URI="http://prdownloads.sourceforge.net/glimmer/${A}"
HOMEPAGE="http://glimmer.sourceforge.net"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	>=gnome-base/ORBit-0.5.10-r1
	>=gnome-base/gnome-vfs-1.0.2-r1
	>=gnome-base/gnome-print-0.30"

# These are requirements when build with --enable-python.
# We should update this to build with --enable-python if USE=python,
# some work might have to be done to make play with Python 2.X

#	>=dev-lang/python-1.5.2
#	>=dev-python/gnome-python-1.4.1"

src_compile() {

#--disable-python disable python scripting, needed to build with python-2.x
# see homepage

	./configure --host=${CHOST}					\
	  	    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    --infodir=/usr/share/info				\
		    --mandir=/usr/share/man				\
		    --disable-python || die
	
	emake || die
}

src_install () {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/varlib					\
	     infodir=${D}/usr/share/info				\
	     mandir=${D}/usr/share/man					\
	     install || die

	dodoc AUTHORS ABOUT-NLS ChangeLog NEWS PROPS TODO README
	dodoc INSTALL COPYING
}
