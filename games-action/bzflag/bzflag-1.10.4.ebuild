# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/bzflag/bzflag-1.10.4.ebuild,v 1.4 2004/06/03 07:49:45 mr_bones_ Exp $

inherit games

MY_P="${P}.20040125"
DESCRIPTION="OpenGL accelerated 3d tank combat simulator game"
HOMEPAGE="http://www.BZFlag.org/"
SRC_URI="mirror://sourceforge/bzflag/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND="virtual/opengl"

S="${WORKDIR}/${PN}-1.10.4.20040125"

src_unpack() {
	unpack ${A}
	cd ${S}
	if use amd64 ; then
		sed -i \
			-e "s/-mcpu=\$host_cpu//" configure \
			|| die "sed failed"
		chmod +x configure
	fi
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README.UNIX TODO README ChangeLog BUGS PORTING
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	ewarn "This version of ${PN} breaks compatibility with all previous releases"
	echo
}
