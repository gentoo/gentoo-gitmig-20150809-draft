# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnet/gnet-2.0.4.ebuild,v 1.7 2004/02/21 05:04:46 vapier Exp $

inherit gnome2

DESCRIPTION="GNet network library."
HOMEPAGE="http://www.gnetlibrary.org/"
SRC_URI="http://www.gnetlibrary.org/src/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc ~sparc alpha ~hppa ia64"

# yes, the >= is correct, this software can use both glib 1.2 and 2.0!
RDEPEND=">=dev-libs/glib-1.2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

G2CONF=" --with-html-dir=${D}/usr/share/gtk-doc/html"

DOCS="AUTHORS BUGS ChangeLog COPYING HACKING NEWS README TODO"
