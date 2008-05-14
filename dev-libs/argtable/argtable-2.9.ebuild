# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/argtable/argtable-2.9.ebuild,v 1.1 2008/05/14 00:03:22 angelos Exp $

inherit versionator

DESCRIPTION="An ANSI C library for parsing GNU-style command-line options with minimal fuss"
HOMEPAGE="http://argtable.sourceforge.net/"

MY_PV="$(replace_version_separator 1 '-')"
MY_P=${PN}${MY_PV}

SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc debug examples"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf $(use_enable debug) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

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
