# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/streamtuner/streamtuner-0.99.ebuild,v 1.1 2004/11/26 20:21:11 eradicator Exp $

IUSE="xmms"

inherit gnome2 eutils

DESCRIPTION="Stream directory browser for browsing internet radio streams"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/streamtuner/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND=">=x11-libs/gtk+-2.4
	>=net-misc/curl-7.10.8
	>=app-text/scrollkeeper-0.3.0
	>=dev-libs/libxml-1.8.17-r2
	>=media-libs/taglib-1.2"

RDEPEND="${DEPEND}
	 xmms? ( media-sound/xmms )"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"
