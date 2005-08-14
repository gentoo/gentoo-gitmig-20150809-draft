# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsoup/libsoup-2.2.3-r1.ebuild,v 1.8 2005/08/14 10:11:08 hansmi Exp $

inherit gnome2

DESCRIPTION="Soup is a SOAP implementation"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="2.2"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="doc ssl static"

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/libxml2-2
	ssl? ( >=net-libs/gnutls-1
		>=dev-libs/libgpg-error-0.4 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog README* TODO"

G2CONF="${G2CONF} $(use_enable ssl) $(use_enable static) \
$(use_enable static static-ssl)"

