# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/liferea/liferea-1.0_rc3.ebuild,v 1.3 2006/01/12 23:25:53 compnerd Exp $

inherit gnome2

MY_P="${P/_rc/-RC}"

DESCRIPTION="News Aggregator for RDF/RSS/CDF/Atom/Echo/etc feeds"
HOMEPAGE="http://liferea.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="dbus firefox gtkhtml mozilla"

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/libxml2-2.5.10
	firefox? ( www-client/mozilla-firefox )
	!firefox? ( mozilla? ( www-client/mozilla ) )
	gtkhtml? ( =gnome-extra/gtkhtml-2* )
	!mozilla? ( !firefox? ( =gnome-extra/gtkhtml-2* ) )
	>=gnome-base/gconf-2
	dbus? ( >=sys-apps/dbus-0.30 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="README AUTHORS ChangeLog COPYING"
USE_DESTDIR="1"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if ! use gtkhtml && ! use mozilla && ! use firefox ; then
		ewarn "None of the \"gtkhtml\", \"mozilla\" or \"firefox\" HTML backends"
		ewarn "was selected by USE flags. Will use \"gtkhtml\"."
	elif use mozilla && use firefox ; then
		ewarn "Both \"mozilla\" and \"firefox\" were selected by USE flags."
		ewarn "Will use \"firefox\"."
	fi
}

src_compile() {
	if ! use mozilla && ! use firefox || use gtkhtml ; then
		G2CONF="${G2CONF} --enable-gtkhtml2"
	else
		G2CONF="${G2CONF} --disable-gtkhtml2"
	fi
	if use firefox ; then
		G2CONF="${G2CONF} --enable-gecko=firefox"
	elif use mozilla ; then
		G2CONF="${G2CONF} --enable-gecko=mozilla"
	else
		G2CONF="${G2CONF} --disable-gecko"
	fi
	G2CONF="${G2CONF} $(use_enable dbus)"
	gnome2_src_compile
}
