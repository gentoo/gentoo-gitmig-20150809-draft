# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmime/gmime-2.1.9.ebuild,v 1.2 2004/10/07 12:11:12 blubb Exp $

inherit gnome2 eutils

IUSE="doc ipv6"
DESCRIPTION="Utilities for creating and parsing messages using MIME"
SRC_URI="http://spruce.sourceforge.net/gmime/sources/v${PV%.*}/${P}.tar.gz"
HOMEPAGE="http://spruce.sourceforge.net/gmime/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

RDEPEND=">=dev-libs/glib-2
	doc? ( >=dev-util/gtk-doc-1.0 )"

DEPEND="dev-util/pkgconfig
	doc? ( app-text/docbook-sgml-utils )
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	#db2html should be docbook2html
	sed -i -e 's:db2html:docbook2html:g' \
		docs/tutorial/Makefile.am docs/tutorial/Makefile.in \
		|| die "sed failed (1)"
}

src_compile() {
	econf \
	    `use_enable ipv6` \
	    `use_enable doc gtk-doc` || die "configure failed"
}

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS PORTING README TODO doc/html/"

