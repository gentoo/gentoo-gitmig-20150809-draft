# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/liferea/liferea-1.1.6.ebuild,v 1.2 2006/10/03 13:25:10 dang Exp $

inherit gnome2 flag-o-matic eutils autotools

DESCRIPTION="News Aggregator for RDF/RSS/CDF/Atom/Echo/etc feeds"
HOMEPAGE="http://liferea.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="dbus firefox gtkhtml seamonkey libnotify gnutls"

RDEPEND=">=x11-libs/gtk+-2.4.0
	>=dev-libs/libxml2-2.5.10
	|| (
		firefox? ( www-client/mozilla-firefox )
		seamonkey? ( www-client/seamonkey )
		=gnome-extra/gtkhtml-2*
	)
	gtkhtml? ( =gnome-extra/gtkhtml-2* )
	>=gnome-base/gconf-2
	dbus? ( >=sys-apps/dbus-0.30 )
	libnotify? ( >=x11-libs/libnotify-0.3.2 )
	gnutls? ( net-libs/gnutls )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_unpack() {
	unpack ${A}

	cd ${S}

	epatch "${FILESDIR}/${PN}-1.1.0-libnotify.patch"
	
	eautoreconf || die "Autoreconf failed"
}

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

	G2CONF="${G2CONF} \
		$(use_enable dbus) \
		$(use_enable gnutls) \
		$(use_enable libnotify)"
}

src_install() {
	gnome2_src_install
	rm -f ${D}/usr/bin/${PN}
	mv ${D}/usr/bin/${PN}-bin ${D}/usr/bin/${PN}
}
