# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/loudmouth/loudmouth-0.17.1.ebuild,v 1.4 2005/04/02 00:32:42 weeve Exp $

inherit gnome2

DESCRIPTION="Lightweight C Jabber library"
HOMEPAGE="http://loudmouth.imendio.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc ~ppc ~amd64"

IUSE="doc ssl"

RDEPEND=">=dev-libs/glib-2.4
	ssl? ( >=net-libs/gnutls-1.0.0 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.0 )"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

G2CONF="${G2CONF} `use_with ssl` --disable-mono"
# FIXME :  We probably want to add a local mono use flag. However, I have no chance to -test- the monobindings, so I'm just disabling it right now.
