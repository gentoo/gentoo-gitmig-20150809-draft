# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/id3lib/id3lib-3.8.0.ebuild,v 1.2 2002/08/27 04:51:24 mkennedy Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Id3 library for C/C++"
SRC_URI="mirror://sourceforge/id3lib/${MY_P}.tar.gz"
HOMEPAGE="http://id3lib.sourceforge.net/"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_unpack() {

	unpack ${A}

	if [ "`gcc --version | cut -f1 -d.`" == "3" ] ||
	   ([ -n "${CXX}" ] && [ "`${CXX} --version | cut -f1 -d.`" == "3" ]) ||
	   [ "`gcc --version|grep gcc|cut -f1 -d.|cut -f3 -d\ `" == "3" ]
	then
		cd ${S}
		# Removed azarah's patch for _pre2 (doesn't seem to be
		# necessary for gcc3.2), added the following for 3.8.0 from
		# Michael Best <gentoo@pendragon.org> (Bug #6840)
		patch -p0 <${FILESDIR}/${P}-gcc3.patch || die
	fi
}

src_compile() {

	export CPPFLAGS="${CPPFLAGS} -Wno-deprecated"

	econf || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog HISTORY INSTALL README THANKS TODO
#	some example programs to be placed in docs dir.
	make clean
	cp -a examples ${D}/usr/share/doc/${PF}/examples
}
