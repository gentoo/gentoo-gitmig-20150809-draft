# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/liferea/liferea-1.0.21.ebuild,v 1.1 2006/08/10 02:08:54 dang Exp $

inherit gnome2 eutils autotools

DESCRIPTION="News Aggregator for RDF/RSS/CDF/Atom/Echo/etc feeds"
HOMEPAGE="http://liferea.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="dbus firefox gtkhtml seamonkey"

RDEPEND=">=x11-libs/gtk+-2.4.0
	>=dev-libs/libxml2-2.5.10
	firefox? ( www-client/mozilla-firefox )
	!firefox? ( seamonkey? ( www-client/seamonkey ) )
	gtkhtml? ( =gnome-extra/gtkhtml-2* )
	!seamonkey? ( !firefox? ( =gnome-extra/gtkhtml-2* ) )
	>=gnome-base/gconf-2
	dbus? ( >=sys-apps/dbus-0.30 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

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

src_install() {
	gnome2_src_install
	rm -f ${D}/usr/bin/${PN}
	mv ${D}/usr/bin/${PN}-bin ${D}/usr/bin/${PN}
}
