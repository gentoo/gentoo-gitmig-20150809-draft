# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmime/gmime-2.1.14.ebuild,v 1.2 2005/04/02 21:09:13 dsd Exp $

inherit gnome2 eutils mono

IUSE="doc ipv6 mono"
DESCRIPTION="Utilities for creating and parsing messages using MIME"
SRC_URI="http://spruce.sourceforge.net/gmime/sources/v${PV%.*}/${P}.tar.gz"
HOMEPAGE="http://spruce.sourceforge.net/gmime/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND=">=dev-libs/glib-2
	doc? ( >=dev-util/gtk-doc-1.0 )"

DEPEND="dev-util/pkgconfig
	doc? ( app-text/docbook-sgml-utils )
	mono? ( dev-lang/mono
			=dev-dotnet/gtk-sharp-1.0*
			>=dev-dotnet/gtk-sharp-1.0.6 )
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	#db2html should be docbook2html
	sed -i -e 's:db2html:docbook2html -o gmime-tut:g' \
		docs/tutorial/Makefile.am docs/tutorial/Makefile.in \
		|| die "sed failed (1)"
}

src_compile() {
	econf \
	    `use_enable ipv6` \
	    `use_enable mono` \
	    `use_enable doc gtk-doc` || die "configure failed"
	MAKEOPTS="-j1" MONO_PATH=${S} emake || die
}

src_install() {
	make GACUTIL_FLAGS="/root ${D}/usr/$(get_libdir) /gacdir /usr/$(get_libdir) /package ${PN}" \
		DESTDIR=${D} install || die

	if useq doc; then
		docinto tutorial
		dodoc docs/tutorial/html/*
	fi

	# rename these two, so they don't conflict with app-arch/sharutils
	# (bug #70392)	Ticho, 2004-11-10
	mv ${D}/usr/bin/uuencode ${D}/usr/bin/gmime-uuencode
	mv ${D}/usr/bin/uudecode ${D}/usr/bin/gmime-uudecode
}

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS PORTING README TODO doc/html/"
