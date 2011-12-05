# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/loudmouth/loudmouth-1.4.3.ebuild,v 1.13 2011/12/05 19:41:27 jer Exp $

inherit autotools gnome2

DESCRIPTION="Lightweight C Jabber library"
HOMEPAGE="https://github.com/engineyard/loudmouth"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"

IUSE="asyncns doc ssl debug test"

# Automagic libidn dependency
RDEPEND=">=dev-libs/glib-2.4
	net-dns/libidn
	ssl? ( >=net-libs/gnutls-1.4.0 )
	asyncns? ( net-libs/libasyncns )"
# FIXME:
#   openssl dropped because of bug #216705

DEPEND="${RDEPEND}
	test? ( dev-libs/check )
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )
	>=dev-util/gtk-doc-am-1"

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

	# Fix detection of gnutls-2.8, bug #272027
	epatch "${FILESDIR}/${P}-gnutls28.patch"

	eautoreconf
}
