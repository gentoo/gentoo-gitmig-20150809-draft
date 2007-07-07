# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/superswitcher/superswitcher-0.5.ebuild,v 1.1 2007/07/07 11:34:04 swegener Exp $

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
DEPEND="${RDEPEND}"

src_install() {
	emake -j1 install DESTDIR="${D}" || die "emake install failed"
	dodoc ChangeLog README
}
