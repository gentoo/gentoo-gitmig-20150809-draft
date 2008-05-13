# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/streamtuner/streamtuner-0.99.99-r3.ebuild,v 1.1 2008/05/13 06:10:24 drac Exp $

EAPI=1

GCONF_DEBUG=no

inherit gnome2 eutils

DESCRIPTION="Stream directory browser for browsing internet radio streams"
HOMEPAGE="http://www.nongnu.org/streamtuner"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz
	 http://savannah.nongnu.org/download/${PN}/${P}-pygtk-2.6.diff"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="python +shout +xiph"

RDEPEND=">=x11-libs/gtk+-2.4
	net-misc/curl
	app-text/scrollkeeper
	xiph? ( dev-libs/libxml2 )
	>=media-libs/taglib-1.2
	python? ( dev-python/pygtk )
	x11-misc/xdg-utils"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!media-plugins/streamtuner-xiph
	!media-plugins/streamtuner-local
	!media-plugins/streamtuner-live365
	!media-plugins/streamtuner-python"

DOCS="AUTHORS NEWS README TODO"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-shoutcast.patch \
		"${DISTDIR}"/${P}-pygtk-2.6.diff
}

src_compile() {
	# live365 causes parse errors at connect time.
	econf --disable-live365 $(use_enable python) \
		$(use_enable shout shoutcast) $(use_enable xiph)
	emake || die "emake failed."
}
