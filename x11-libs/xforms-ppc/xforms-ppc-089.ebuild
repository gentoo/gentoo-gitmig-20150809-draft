# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xforms-ppc/xforms-ppc-089.ebuild,v 1.4 2002/08/05 10:02:51 seemant Exp $

MY_P="bxform-${PV}-glibc21"
S=${WORKDIR}/${PN/-ppc/}
DESCRIPTION="A GUI Toolkit based on Xlib"
SRC_URI="ftp://ncmir.ucsd.edu/pub/xforms/linux-ppc/${MY_P}.tgz"
HOMEPAGE="http://world.std.com/~xforms/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc -x86 -sparc -sparc64"

PROVIDE="virtual/xforms"

DEPEND="virtual/x11"
RDEPEND=""

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
