# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/loudmouth/loudmouth-0.12.ebuild,v 1.1 2003/07/26 18:46:27 foser Exp $

inherit gnome2

DESCRIPTION="Lightweight C Jabber library"
HOMEPAGE="http://www.imendio.com/projects/loudmouth/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

IUSE="doc"

RDEPEND=">=dev-libs/glib-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.0 )"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
