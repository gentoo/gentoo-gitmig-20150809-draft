# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/txt2tags/txt2tags-1.4.ebuild,v 1.1 2003/04/28 20:27:09 liquidx Exp $

IUSE=""
DESCRIPTION="Txt2tags is a tool for generating marked up documents (HTML, SGML, ...) from a plain text file with markup."
SRC_URI="http://txt2tags.sourceforge.net/src/${P}.tgz"
HOMEPAGE="http://txt2tags.sourceforge.net/"

DEPEND="virtual/python"

LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
SLOT="0"

src_compile() {
	einfo "No compilation necessary"
}

src_install () {
	dobin txt2tags
	dodoc README* RULES
	# samples go into "samples" doc directory
	docinto samples
	dodoc samples/*
	# extras go into "extras" doc directory
	docinto extras
	dodoc extras/*
}
