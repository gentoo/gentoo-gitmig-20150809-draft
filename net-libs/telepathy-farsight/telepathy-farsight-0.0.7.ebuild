# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/telepathy-farsight/telepathy-farsight-0.0.7.ebuild,v 1.1 2009/05/13 15:26:25 tester Exp $

EAPI="2"

DESCRIPTION="Farsight connection manager for the Telepathy framework"
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python"

RDEPEND=">=dev-libs/glib-2.16
	>=sys-apps/dbus-0.60
	>=dev-libs/dbus-glib-0.60
	>=net-libs/telepathy-glib-0.7.29
	>=net-libs/farsight2-0.0.9
	python? (
		>=dev-python/pygobject-2.12.0
		>=dev-python/gst-python-0.10.10 )"

DEPEND="${RDEPEND}"

src_configure() {
	econf $(use_enable python)
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc NEWS ChangeLog
}
