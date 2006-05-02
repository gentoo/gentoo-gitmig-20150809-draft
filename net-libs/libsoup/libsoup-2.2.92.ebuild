# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsoup/libsoup-2.2.92.ebuild,v 1.1 2006/05/02 18:45:19 dang Exp $

inherit gnome2

DESCRIPTION="An HTTP library implementation in C"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="2.2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc ssl static"

RDEPEND=">=dev-libs/glib-2.4
		 >=dev-libs/libxml2-2
		 ssl?	(
		 			>=net-libs/gnutls-1
					>=dev-libs/libgpg-error-0.4
				)"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.9
		doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"


pkg_setup() {
	G2CONF="$(use_enable ssl) $(use_enable static) \
		$(use_enable static static-ssl)"
}
