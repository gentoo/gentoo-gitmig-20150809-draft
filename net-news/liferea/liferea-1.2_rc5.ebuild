# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/liferea/liferea-1.2_rc5.ebuild,v 1.1 2006/12/12 00:45:13 dang Exp $

inherit gnome2 flag-o-matic eutils autotools

MY_P=${P/_rc/-RC}
DESCRIPTION="News Aggregator for RDF/RSS/CDF/Atom/Echo/etc feeds"
HOMEPAGE="http://liferea.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="dbus firefox gtkhtml seamonkey libnotify gnutls xulrunner"

RDEPEND=">=x11-libs/gtk+-2.8
	x11-libs/pango
	>=gnome-base/gconf-2
	>=dev-libs/libxml2-2.5.10
	dev-libs/libxslt
	>=dev-libs/glib-2
	xulrunner? ( net-libs/xulrunner )
	!xulrunner? ( firefox? ( www-client/mozilla-firefox ) )
	!xulrunner? ( !firefox? ( seamonkey? ( www-client/seamonkey ) ) )
	!xulrunner? ( !firefox? ( !seamonkey? ( =gnome-extra/gtkhtml-2* ) ) )
	gtkhtml? ( =gnome-extra/gtkhtml-2* )
	dbus? ( || ( >=dev-libs/dbus-glib-0.71
		( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.36 ) )
	)
	libnotify? ( >=x11-libs/libnotify-0.3.2 )
	gnutls? ( net-libs/gnutls )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35
	=sys-devel/automake-1.7*"

DOCS="AUTHORS ChangeLog NEWS README"

S=${WORKDIR}/${MY_P}
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

	# we prefer xulrunner over firefox over seamonkey
	if use xulrunner ; then
		G2CONF="${G2CONF} --enable-gecko=xulrunner"
	elif use firefox ; then
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
