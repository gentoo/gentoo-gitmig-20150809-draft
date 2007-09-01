# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-stream-engine/telepathy-stream-engine-0.3.25.ebuild,v 1.1 2007/09/01 10:33:18 peper Exp $

DESCRIPTION="A Telepathy client that handles channels of type 'StreamedMedia'"
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/stream-engine/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=dev-libs/glib-2.4
	dev-libs/libxml2
	>=media-libs/farsight-0.1.23
	=media-libs/gst-plugins-base-0.10*
	>=net-libs/libtelepathy-0.0.53
	>=dev-libs/dbus-glib-0.71"

RDEPEND="${DEPEND}"

src_compile() {
	econf \
		$(use_enable debug backtrace) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake failed"
	dodoc TODO ChangeLog
}
