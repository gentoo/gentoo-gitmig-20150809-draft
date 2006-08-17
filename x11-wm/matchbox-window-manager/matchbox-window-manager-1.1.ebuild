# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/matchbox-window-manager/matchbox-window-manager-1.1.ebuild,v 1.1 2006/08/17 15:54:21 yvasilev Exp $

inherit eutils versionator gnome2

DESCRIPTION="Light weight WM designed for use on PDA computers"
HOMEPAGE="http://projects.o-hand.com/matchbox/"
SRC_URI="http://projects.o-hand.com/matchbox/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"

KEYWORDS="~arm ~x86"
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
	epatch "${FILESDIR}/${PN}-1.0-use-nopng.patch"
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
	# we must delay gconf schema installation due to sandbox
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make DESTDIR="${D}" install || die "Installation failed"
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL

	gnome2_gconf_install

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
