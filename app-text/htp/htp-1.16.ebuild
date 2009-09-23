# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htp/htp-1.16.ebuild,v 1.3 2009/09/23 16:36:34 patrick Exp $

inherit distutils eutils

DESCRIPTION="An HTML preprocessor"
HOMEPAGE="http://htp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND=""
RDEPEND=""

# HTP does not use autoconf, have to set options defined in Makefile.config

src_unpack() {
	unpack ${A} || die
	cd "${S}"
	# Patch to remove meta-generator tag with "ego-gratifying Easter egg":
	epatch "${FILESDIR}/easteregg.patch"
	# Fix for #240110
	epatch "${FILESDIR}/strip.patch"
}

src_compile() {
	emake CCOPT="-c ${CFLAGS}" || die
}

src_install() {
	make DESTDIR="${D}" prefix="${D}/usr" pkgdocdir="${D}/usr/share/doc/${PF}" \
		install || die
}
