# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnet/gnet-2.0.7.ebuild,v 1.3 2005/04/12 00:46:10 gustavoz Exp $

inherit gnome2

DESCRIPTION="A simple network library."
HOMEPAGE="http://www.gnetlibrary.org/"
SRC_URI="http://www.gnetlibrary.org/src/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="x86 ~ppc sparc ~alpha ~hppa ~ia64 ~amd64 ~ppc-macos"

IUSE="debug doc static"

RDEPEND=">=dev-libs/glib-1.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.2 )"

DOCS="AUTHORS BUGS ChangeLog HACKING NEWS README* TODO"

G2CONF="${G2CONF} $(use_enable static)"
