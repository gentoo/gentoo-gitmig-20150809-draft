# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tod M. Neidt <tneidt@fidnet.com>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

#Remeber to add the proper Author line, above.  Don't worry about the
# fourth line; it'll get automatically fixed when the ebuild is checked in

#Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}
A=glimmer-1.1.9-1.tar.gz
S=${WORKDIR}/glimmer-1.1.9-1

#Short one-line description
DESCRIPTION="All-purpose gnome code editor."

#Point to any required sources; these will be automatically downloaded
# by Portage
SRC_URI="http://prdownloads.sourceforge.net/glimmer/${A}"

#Homepage hasn't been moved to sourceforge yet.
HOMEPAGE="http://glimmer.sourceforge.net"

#build-time dependencies
DEPEND=">=gnome-base/gnome-libs-1.2.13
	>=gnome-base/ORBit-0.5.8
	>=gnome-base/gnome-vfs-1.0
	>=gnome-base/gnome-print-0.25
	>=dev-lang/python-1.5.2
	>=dev-python/gnome-python-1.4.1"

#run-time dependencies, same as DEPEND if RDEPEND isn't defined:
RDEPEND=""

src_compile() {

#--disable-python disable python scripting, needed to build with python-2.x
# see homepage

	./configure --disable-python --infodir=/opt/gnome/info --mandir=/opt/gnome/man --prefix=/opt/gnome --host=${CHOST} || die
	
	emake || die

	#make || die
}

src_install () {
	
	make prefix=${D}/opt/gnome install || die
	dodoc AUTHORS ABOUT-NLS ChangeLog NEWS PROPS TODO README INSTALL COPYING
   # make DESTDIR=${D} install || die
}

