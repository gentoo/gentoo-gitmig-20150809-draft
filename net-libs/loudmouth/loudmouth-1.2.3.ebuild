# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/loudmouth/loudmouth-1.2.3.ebuild,v 1.6 2008/03/18 09:50:21 remi Exp $

inherit gnome2

DESCRIPTION="Lightweight C Jabber library"
HOMEPAGE="http://www.loudmouth-project.org/"
SRC_URI="http://ftp.imendio.com/pub/imendio/${PN}/src/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

IUSE="doc gnutls ssl debug test"

RDEPEND=">=dev-libs/glib-2.4
	ssl? ( || (
		gnutls? ( >=net-libs/gnutls-1.4.0 )
		!gnutls? ( dev-libs/openssl )
		) )"

DEPEND="${RDEPEND}
	test? ( dev-libs/check )
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable debug)"

	if use ssl && use gnutls; then
		G2CONF="${G2CONF} --with-ssl=gnutls"
	elif use ssl; then
		G2CONF="${G2CONF} --with-ssl=openssl"
	else
		G2CONF="${G2CONF} --with-ssl=no"
	fi
}
