# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/liferea/liferea-0.4.9.ebuild,v 1.3 2004/06/25 00:57:18 agriffis Exp $

inherit gnome2

DESCRIPTION="News Aggregator for RDF/RSS/CDF/Atom/Echo/etc similar to FeedReader."
HOMEPAGE="http://liferea.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=x11-libs/gtk+-2*
	>=dev-libs/libxml2-2.5.10
	gtkhtml? ( >=gnome-extra/libgtkhtml-2 )
	mozilla? ( net-www/mozilla )
	>=gnome-base/gconf-2"

pkg_setup(){
	ewarn "If you run this version of liferea without backing up your feedlist"
	ewarn "you might lose it, please export to opml before upgrading to avoid"
	ewarn "this issue."
	ewarn "Please ctrl+c now if you'd like to save your feed list."
	sleep 8
}

DOCS="README AUTHORS ChangeLog COPYING"
