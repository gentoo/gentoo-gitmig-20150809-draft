# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Header: $

MY_P="bxform-${PV}-glibc2.1"
MY_D="linux-i386/elf"

# for unkown reasons ${ARCH} will just _not_ work here
# even though it returns "ppc" (as does `arch`)
if [ `arch` = "ppc" ] ; then
	MY_D="linuxppc"
	MY_P=${MY_P}"-ppc"
fi

S=${WORKDIR}/${PN}
DESCRIPTION="A GUI Toolkit based on Xlib"
SRC_URI="ftp://ncmir.ucsd.edu/pub/xforms/${MY_D}/${MY_P}.tgz"
HOMEPAGE="http://world.std.com/~xforms/"
SLOT="0"
DEPEND="virtual/x11"
RDEPEND=""
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

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

