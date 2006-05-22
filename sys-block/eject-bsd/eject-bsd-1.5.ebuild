# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/eject-bsd/eject-bsd-1.5.ebuild,v 1.1 2006/05/22 23:35:18 flameeyes Exp $

inherit eutils portability toolchain-funcs

MY_P="eject-${PV}"

DESCRIPTION="eject command for FreeBSD systems"
HOMEPAGE="http://www.freshports.org/sysutils/eject/"
SRC_URI="ftp://ports.jp.FreeBSD.org/pub/FreeBSD-jp/OD/${MY_P}.tar.gz
	ftp://ftp4.jp.FreeBSD.org/pub/FreeBSD-jp/OD/${MY_P}.tar.gz
	ftp://ftp.ics.es.osaka-u.ac.jp/pub/mirrors/FreeBSD-jp/OD/${MY_P}.tar.gz
	ftp://ftp.FreeBSD.org/pub/FreeBSD/ports/distfiles/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="!sys-apps/eject"
PROVIDE="virtual/eject"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-manpage.patch"
	epatch "${FILESDIR}/${P}-devname.patch"
}

src_compile() {
	$(get_bmake) CC="$(tc-getCC)" PREFIX="/usr" eject || die "$(get_bmake) failed"
}

src_install() {
	dobin ${S}/eject
	doman ${S}/eject.1
	dodoc ${S}/README
}

