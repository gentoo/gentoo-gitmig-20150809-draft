# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/loudmouth/loudmouth-0.13.2-r1.ebuild,v 1.1 2003/09/07 13:14:16 foser Exp $

inherit gnome2

DESCRIPTION="Lightweight C Jabber library"
HOMEPAGE="http://www.imendio.com/projects/loudmouth/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

IUSE="doc"

RDEPEND=">=dev-libs/glib-2
	ssl? ( net-libs/gnutls )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.0 )"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

use ssl \
	&& G2CONF="${G2CONF} --with-ssl" \
	|| G2CONF="${G2CONF} --without-ssl"

