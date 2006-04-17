# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/loudmouth/loudmouth-1.0.1.ebuild,v 1.6 2006/04/17 17:56:20 corsair Exp $

inherit gnome2

DESCRIPTION="Lightweight C Jabber library"
HOMEPAGE="http://loudmouth.imendio.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc ~x86"

IUSE="doc ssl"

RDEPEND=">=dev-libs/glib-2.4
	ssl? ( >=net-libs/gnutls-1 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

USE_DESTDIR="1"
