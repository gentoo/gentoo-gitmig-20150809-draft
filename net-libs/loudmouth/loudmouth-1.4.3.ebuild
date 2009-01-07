# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/loudmouth/loudmouth-1.4.3.ebuild,v 1.2 2009/01/07 16:58:19 armin76 Exp $

inherit autotools gnome2

DESCRIPTION="Lightweight C Jabber library"
HOMEPAGE="http://www.loudmouth-project.org/"
SRC_URI="http://ftp.imendio.com/pub/imendio/${PN}/src/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="asyncns doc ssl debug test"

RDEPEND=">=dev-libs/glib-2.4
	ssl? ( >=net-libs/gnutls-1.4.0 )
	asyncns? ( net-libs/libasyncns )"
# FIXME:
#   openssl dropped because of bug #216705

DEPEND="${RDEPEND}
	test? ( dev-libs/check )
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable debug)"

	if use ssl; then
		G2CONF="${G2CONF} --with-ssl=gnutls"
	else
		G2CONF="${G2CONF} --with-ssl=no"
	fi

	if use asyncns; then
		G2CONF="${G2CONF} --with-asyncns=system"
	else
		G2CONF="${G2CONF}  --without-asyncns"
	fi
}

src_unpack() {
	gnome2_src_unpack

	# Use system libasyncns, bug #236844
	epatch "${FILESDIR}/${P}-asyncns-system.patch"

	eautoreconf
}
