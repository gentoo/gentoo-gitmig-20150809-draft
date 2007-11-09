# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/avant-window-navigator/avant-window-navigator-0.2.1.ebuild,v 1.1 2007/11/09 17:43:53 wltjr Exp $

DESCRIPTION="Fully customisable dock-like window navigator for GNOME."
HOMEPAGE="http://launchpad.net/awn"
SRC_URI="http://launchpad.net/awn/${PV%.*}/${PV}/+download/${P}.tar"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/glib-2.8
	gnome-extra/gconf-editor
	x11-libs/libwnck"
RDEPEND="${DEPEND}"


src_compile() {
	econf --sharedstatedir="/usr/share"|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	dodoc NEWS README
}
