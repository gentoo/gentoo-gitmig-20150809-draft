# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/bzflag/bzflag-1.10.4.ebuild,v 1.3 2004/04/19 21:24:35 wolf31o2 Exp $

inherit games

MY_P="${P}.20040125"
S="${WORKDIR}/${PN}-1.10.4.20040125"
DESCRIPTION="OpenGL accelerated 3d tank combat simulator game"
HOMEPAGE="http://www.BZFlag.org/"
SRC_URI="mirror://sourceforge/bzflag/${MY_P}.tar.bz2"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64"

DEPEND="virtual/opengl"

src_compile () {
	if [ "`use amd64`" ]; then
		sed -e "s/-mcpu=\$host_cpu//" configure > configure.new
		mv configure.new configure
		chmod +x configure
	fi
	egamesconf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS README.UNIX TODO README ChangeLog BUGS PORTING || \
		die "dodoc failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "This version of ${PN} breaks compatibility with all previous releases"
	echo
}
