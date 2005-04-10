# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/gurlchecker/gurlchecker-0.8.1.ebuild,v 1.1 2005/04/10 00:43:58 leonardop Exp $

inherit gnome2

DESCRIPTION="Gnome tool that checks links on web pages/sites"
HOMEPAGE="http://gurlchecker.labs.libre-entreprise.org/"
SRC_URI="http://labs.libre-entreprise.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE="doc gnutls"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=dev-libs/libxml2-2.6
	>=net-libs/gnet-2
	gnutls? ( >=net-libs/gnutls-1 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.25
	doc? ( >=dev-util/gtk-doc-1.1 )"

DOCS="ABOUT-NLS AUTHORS ChangeLog FAQ NEWS README THANKS TODO"

G2CONF="${G2CONF} $(use_with gnutls)"
