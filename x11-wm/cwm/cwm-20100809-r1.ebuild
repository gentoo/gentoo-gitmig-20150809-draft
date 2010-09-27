# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/cwm/cwm-20100809-r1.ebuild,v 1.1 2010/09/27 00:29:07 xmw Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="OpenBSD fork of calmwm, a clean and lightweight window manager"
HOMEPAGE="http://www.openbsd.org/cgi-bin/man.cgi?query=cwm&sektion=1"
SRC_URI="http://xmw.de/mirror/${PN}/${P}.tar.bz2
	http://xmw.de/mirror/${PN}/${PF}.patch.tar.bz2"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libXft
	x11-libs/libXinerama
	x11-libs/libXrandr"
DEPEND="${RDEPEND}
	sys-devel/bison"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch linux.patch
	sed -i -e '/^CFLAGS/s:-Wall::' Makefile || die
}

src_compile() {
	export LDADD="${LDFLAGS}"
	tc-export CC
	emake || die
}

src_install() {
	dobin ${PN} || die
	doman ${PN}.1 ${PN}rc.5 || die
}
