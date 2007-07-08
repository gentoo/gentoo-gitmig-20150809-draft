# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/liferea/liferea-1.0.16.ebuild,v 1.9 2007/07/08 05:51:42 mr_bones_ Exp $

inherit gnome2 eutils autotools

DESCRIPTION="News Aggregator for RDF/RSS/CDF/Atom/Echo/etc feeds"
HOMEPAGE="http://liferea.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="dbus firefox gtkhtml seamonkey"

RDEPEND=">=x11-libs/gtk+-2.4.0
	>=dev-libs/libxml2-2.5.10
	firefox? ( www-client/mozilla-firefox )
	!firefox? ( seamonkey? ( www-client/seamonkey ) )
	gtkhtml? ( =gnome-extra/gtkhtml-2* )
	!seamonkey? ( !firefox? ( =gnome-extra/gtkhtml-2* ) )
	>=gnome-base/gconf-2
	dbus? ( || ( >=dev-libs/dbus-glib-0.71
		>=sys-apps/dbus-0.36 )
	)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	=sys-devel/automake-1.7*"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {

	# if you don't choose a gecko to use, we will automatically
	# use gtkhtml2 as the backend.
	if ! use seamonkey && ! use firefox || use gtkhtml ; then
		G2CONF="${G2CONF} --enable-gtkhtml2"
	else
		G2CONF="${G2CONF} --disable-gtkhtml2"
	fi

	# we prefer firefox over seamonkey
	if use firefox ; then
		G2CONF="${G2CONF} --enable-gecko=firefox"
	elif use seamonkey ; then
		G2CONF="${G2CONF} --enable-gecko=seamonkey"
	else
		G2CONF="${G2CONF} --disable-gecko"
	fi

	G2CONF="${G2CONF} $(use_enable dbus)"
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch "${FILESDIR}/${P}-seamonkey.diff" || die "Failed patching for seamonkey"

	eautoreconf || die "Failed running eautoreconf"
}

src_install() {
	gnome2_src_install
	rm -f ${D}/usr/bin/${PN}
	mv ${D}/usr/bin/${PN}-bin ${D}/usr/bin/${PN}
}
