# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/loudmouth/loudmouth-0.15.ebuild,v 1.2 2004/02/06 02:01:34 liquidx Exp $

inherit gnome2

DESCRIPTION="Lightweight C Jabber library"
HOMEPAGE="http://loudmouth.imendio.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

IUSE="doc ssl"

RDEPEND=">=dev-libs/glib-2
	ssl? ( net-libs/gnutls )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.0 )"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

use ssl \
	&& G2CONF="${G2CONF} --with-ssl" \
	|| G2CONF="${G2CONF} --without-ssl"

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/${P}-gnutls_1.0.patch
}
