# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnet/gnet-2.0.5.ebuild,v 1.16 2007/02/04 08:26:18 mr_bones_ Exp $

inherit eutils gnome2

DESCRIPTION="GNet network library."
HOMEPAGE="http://www.gnetlibrary.org/"
SRC_URI="http://www.gnetlibrary.org/src/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="x86 ppc sparc alpha hppa ia64 amd64 ~ppc-macos ppc64"

IUSE="doc"

RDEPEND=">=dev-libs/glib-1.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )"

G2CONF=" --with-html-dir=${D}/usr/share/gtk-doc/html"

DOCS="AUTHORS BUGS ChangeLog COPYING HACKING NEWS README TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Fix DocBook conflict. See bug #43942.
	epatch ${FILESDIR}/${P}-gtkdoc_fix.patch
}
