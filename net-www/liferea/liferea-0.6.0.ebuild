# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/liferea/liferea-0.6.0.ebuild,v 1.2 2004/10/30 21:56:21 lv Exp $

inherit gnome2

DESCRIPTION="News Aggregator for RDF/RSS/CDF/Atom/Echo/etc feeds"
HOMEPAGE="http://liferea.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 amd64 ppc"
IUSE="mozilla gtkhtml"

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/libxml2-2.5.10
	mozilla? ( net-www/mozilla
		gtkhtml? ( =gnome-extra/libgtkhtml-2* )
	)
	!mozilla? ( =gnome-extra/libgtkhtml-2* )
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup(){
	ewarn "If you run this version of liferea without backing up your feedlist"
	ewarn "you might lose it, please export to opml before upgrading to avoid"
	ewarn "this issue."
	ewarn "Please ctrl+c now if you'd like to save your feed list."
	sleep 8
}

src_unpack(){
	unpack ${A}
	cd ${S}
}
DOCS="README AUTHORS ChangeLog COPYING"
