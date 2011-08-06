# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/telepathy-inspector/telepathy-inspector-0.5.3.ebuild,v 1.3 2011/08/06 10:11:56 zmedico Exp $

EAPI=1

inherit eutils flag-o-matic

DESCRIPTION="The swiss-army knife of every Telepathy developer."
HOMEPAGE="http://telepathy.freedesktop.org/wiki/TelepathyInspector"
SRC_URI="http://telepathy.freedesktop.org/releases/telepathy-inspector/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86 ~x86-linux"
IUSE=""

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	>=net-libs/telepathy-glib-0.7.14
	gnome-base/libglade
	dev-libs/dbus-glib"
DEPEND="${RDEPEND}
	dev-lang/python
	dev-libs/libxslt
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
