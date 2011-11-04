# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/yelp-tools/yelp-tools-3.2.1.ebuild,v 1.1 2011/11/04 06:09:18 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Collection of tools for building and converting documentation"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 freedist" # yelp.m4 is freely distributable
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.8
	dev-util/itstool
	gnome-extra/yelp-xsl
	sys-apps/gawk"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS NEWS README"
