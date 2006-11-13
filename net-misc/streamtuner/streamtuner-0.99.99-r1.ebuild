# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/streamtuner/streamtuner-0.99.99-r1.ebuild,v 1.4 2006/11/13 15:13:37 flameeyes Exp $

IUSE=""

inherit gnome2 eutils

DESCRIPTION="Stream directory browser for browsing internet radio streams"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz
	 http://savannah.nongnu.org/download/${PN}/${P}-pygtk-2.6.diff"
HOMEPAGE="http://www.nongnu.org/streamtuner/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND=">=x11-libs/gtk+-2.4
	>=net-misc/curl-7.10.8
	>=app-text/scrollkeeper-0.3.0
	dev-libs/libxml2
	>=media-libs/taglib-1.2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-sedfix.patch
	epatch ${DISTDIR}/${P}-pygtk-2.6.diff
}
