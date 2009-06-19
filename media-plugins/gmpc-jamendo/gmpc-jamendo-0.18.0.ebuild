# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-jamendo/gmpc-jamendo-0.18.0.ebuild,v 1.2 2009/06/19 08:26:36 ssuominen Exp $

EAPI=2

DESCRIPTION="Plugin allows you to browse and preview music available on jamendo."
HOMEPAGE="http://gmpc.wikia.com/wiki/GMPC_PLUGIN_JAMENDO"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	>=media-libs/libmpd-0.15.98
	dev-db/sqlite:3
	sys-libs/zlib
	>=dev-libs/libxml2-2.6
	>=x11-libs/gtk+-2.4:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/gob"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
}
