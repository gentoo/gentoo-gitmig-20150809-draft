# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnet/gnet-2.0.2.ebuild,v 1.1 2003/05/07 12:57:32 foser Exp $

inherit gnome2 

DESCRIPTION="GNet network library."
SRC_URI="http://www.gnetlibrary.org/src/${P}.tar.gz"
HOMEPAGE="http://www.gnetlibrary.org/"

SLOT="2"
LICENSE="LGPL-2"
KEYWORDS="~x86"

# yes, the >= is correct, this software can use both glib 1.2 and 2.0!
DEPEND=">=dev-libs/glib-1.2.0"

G2CONF=" --with-html-dir=${D}/usr/share/doc/${PF}" 

DOCS="AUTHORS BUGS ChangeLog COPYING NEWS README TODO"
