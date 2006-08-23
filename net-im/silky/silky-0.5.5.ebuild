# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silky/silky-0.5.5.ebuild,v 1.1 2006/08/23 23:01:43 hanno Exp $

DESCRIPTION="Simple and easy to use GTK+ based os-independent SILC client."
HOMEPAGE="http://silky.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
KEYWORDS="~x86 ~ppc ~sparc"
LICENSE="GPL-2"
IUSE=""

SLOT="0"

DEPEND=">=gnome-base/libglade-2
	>=x11-libs/gtk+-2.2
	x11-libs/pango
	app-misc/mime-types
	>=net-im/silc-toolkit-0.9.12-r2"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
