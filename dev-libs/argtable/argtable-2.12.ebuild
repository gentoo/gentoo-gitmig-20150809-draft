# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/argtable/argtable-2.12.ebuild,v 1.5 2010/07/11 11:47:12 armin76 Exp $

inherit versionator

DESCRIPTION="An ANSI C library for parsing GNU-style command-line options with minimal fuss"
HOMEPAGE="http://argtable.sourceforge.net/"

MY_PV="$(replace_version_separator 1 '-')"
MY_P=${PN}${MY_PV}

SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doc debug examples"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf $(use_enable debug)
	emake || die "build failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	rm -rf "${D}"/usr/share/doc/${PN}2/

	dodoc AUTHORS ChangeLog NEWS README

	if use doc ; then
		cd "${S}/doc"
		dohtml *.html *.gif
		dodoc *.pdf *.ps
	fi

	if use examples ; then
		cd "${S}/example"
		docinto examples
		dodoc Makefile *.[ch] README.txt
	fi
}
