# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/ctags/ctags-5.0.1.ebuild,v 1.1 2001/07/08 18:30:22 g2boojum Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Ctags generates an index (or tag) file of C language objects found in C source and header files that allows these items to be quickly and easily located by a text editor or other utility. Currently supports 22 programming languages."

SRC_URI="http://prdownloads.sourceforge.net/ctags/${P}.tar.gz"

#Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://ctags.sourceforge.net"

#build-time dependencies
DEPEND=""

#run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

src_compile() {
    #the "try" command will stop the build process if the specified command fails.  Prefix critical
	#commands with "try"
	try ./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST}
    #Note the use of --infodir and --mandir, above.  This is to make this package FHS 2.2-compliant
	#(/usr/share is used for info and man now).
	
	try emake
	#emake (previously known as pmake) is a script that calls the standard GNU make with parallel
	#building options for speedier builds on SMP systems.  Use emake first; it make not work.  If
	#not, then replace the line above with:
	
	#try make
}

src_install () {
	#you must *personally verify* that this trick doesn't install
	#anything outside of DESTDIR; do this by reading and understanding
	#the install part of the Makefiles.  Also note that this will often
	#also work for autoconf stuff (usually much more often than DESTDIR,
	#which is actually quite rare.
	
	try make prefix=${D}/usr mandir=${D}/usr/share/man install

    	#try make DESTDIR=${D} install
	#again, verify the Makefiles!  We don't want anything falling outside
	#of ${D}.
}

