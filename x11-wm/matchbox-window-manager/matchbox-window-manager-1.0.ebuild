# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/matchbox-window-manager/matchbox-window-manager-1.0.ebuild,v 1.2 2006/06/14 21:50:45 yvasilev Exp $

inherit eutils versionator

DESCRIPTION="Light weight WM designed for use on PDA computers"
HOMEPAGE="http://projects.o-hand.com/matchbox/"
SRC_URI="http://projects.o-hand.com/matchbox/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"

KEYWORDS="~x86"
IUSE="debug expat gnome session startup-notification xcomposite"

DEPEND=">=x11-libs/libmatchbox-1.5
	expat? ( dev-libs/expat )
	gnome? ( gnome-base/gconf )
	startup-notification? ( x11-libs/startup-notification )
	session? ( || (	x11-libs/libSM
			virtual/x11 ) )
	xcomposite? ( || ( (	x11-libs/libXcomposite
				x11-libs/libXdamage )
			virtual/x11 ) )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Allows to build with USE=-png
	epatch "${FILESDIR}/${P}-use-nopng.patch"
}

src_compile() {
	econf 	--enable-keyboard \
		--enable-ping-protocol \
		--enable-xrm \
		$(use_enable debug) \
		$(use_enable session) \
		$(use_enable expat) \
		$(use_enable gnome gconf) \
		$(use_enable startup-notification) \
		$(use_enable xcomposite composite) \
		|| die "Configuration failed"

	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
