# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/superswitcher/superswitcher-0.6.ebuild,v 1.3 2008/01/09 19:53:01 swegener Exp $

inherit eutils

DESCRIPTION="A more feature-full replacement of the Alt-Tab window switching behavior."
HOMEPAGE="http://code.google.com/p/superswitcher/"
SRC_URI="http://superswitcher.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.6
	>=x11-libs/libwnck-2.10"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-wnck-workspace.patch
}

src_install() {
	emake -j1 install DESTDIR="${D}" || die "emake install failed"
	dodoc ChangeLog README
}
