# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdiskusage/xdiskusage-1.48.ebuild,v 1.11 2011/03/20 20:04:02 ssuominen Exp $

EAPI=1
inherit eutils

DESCRIPTION="front end to xdu for viewing disk usage graphically under X11"
HOMEPAGE="http://xdiskusage.sourceforge.net/"
SRC_URI="http://xdiskusage.sourceforge.net/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/fltk:1"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-amd64.patch
}

src_compile() {
	econf

	emake -j1 \
		CXXFLAGS="$CXXFLAGS `fltk-config --cxxflags`" \
		LDLIBS="`fltk-config --ldflags`" || die
}

src_install() {
	dobin xdiskusage || die
	doman xdiskusage.1
	dodoc README
}
