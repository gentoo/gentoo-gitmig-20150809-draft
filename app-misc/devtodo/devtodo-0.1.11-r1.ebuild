# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author AJ Lewis <roadrunner@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/devtodo/devtodo-0.1.11-r1.ebuild,v 1.1 2001/08/15 19:32:35 tadpol Exp $

#Source directory; the dir where the sources can be found (automatically unpacked)
S=${WORKDIR}/${P}

#Short one-line description
DESCRIPTION="A nice command line todo list for developers"

#Point to any required sources; these will be automatically downloaded by Portage
SRC_URI="http://activelysecure.net/~alec/development/devtodo/0.1.11/${P}.tar.gz"

#Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://activelysecure.net/~alec/development/devtodo/"

#build-time dependencies
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1
	>=sys-devel/gcc-2.95.3"

#run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

src_unpack() {
    unpack ${A}
    cd ${S}
    patch -p1 < ${FILESDIR}/${P}.colourplain.patch
}

src_compile() {
    #the "try" command will stop the build process if the specified command fails.  Prefix critical
	#commands with "try"
	try ./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST}
    #Note the use of --infodir and --mandir, above.  This is to make this package FHS 2.2-compliant
	#(/usr/share is used for info and man now).
	
	try make
	#emake (previously known as pmake) is a script that calls the standard GNU make with parallel
	#building options for speedier builds on SMP systems.  Use emake first; it might not work.  If
	#not, then replace the line above with:
	
	#try make
}

src_install () {
	#you must *personally verify* that this trick doesn't install
	#anything outside of DESTDIR; do this by reading and understanding
	#the install part of the Makefiles.  Also note that this will often
	#also work for autoconf stuff (usually much more often than DESTDIR,
	#which is actually quite rare.
	
	# try make prefix=${D}/usr install

    try make DESTDIR=${D} install
	#again, verify the Makefiles!  We don't want anything falling outside
	#of ${D}.

    dodoc AUTHORS COPYING ChangeLog QuickStart README TODO
}

