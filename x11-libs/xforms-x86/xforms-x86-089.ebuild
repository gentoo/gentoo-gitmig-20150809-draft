# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xforms-x86/xforms-x86-089.ebuild,v 1.2 2002/07/22 03:56:44 seemant Exp $

MY_P="bxform-${PV}-glibc2.1"

S=${WORKDIR}/${PN/-x86/}
DESCRIPTION="A GUI Toolkit based on Xlib"
SRC_URI="ftp://ncmir.ucsd.edu/pub/xforms/linux-i386/elf/${MY_P}.tgz"
HOMEPAGE="http://world.std.com/~xforms/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -sparc64"

PROVIDE="virtual/xforms"

DEPEND="virtual/x11"

src_compile() {
	make || die
}

src_install () {

	into /usr/X11R6
	dolib FORMS/libforms.{a,so.*}
	dobin DESIGN/fdesign
	doman DESIGN/fdesign.1
	dobin fd2ps/fd2ps
	doman fd2ps/fd2ps.1
	dosym /usr/X11R6/lib/libforms.so.0.89 /usr/X11R6/lib/libforms.so
	insinto /usr/X11R6/include
	doins FORMS/forms.h
	doman FORMS/xforms.5
        
}
