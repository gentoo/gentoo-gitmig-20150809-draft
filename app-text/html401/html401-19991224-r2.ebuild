# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/html401/html401-19991224-r2.ebuild,v 1.1 2004/11/06 12:56:17 usata Exp $

inherit sgml-catalog eutils

DESCRIPTION="DTDs for the HyperText Markup Language 4.01"
HOMEPAGE="http://www.w3.org/TR/${PN}/"
SRC_URI="http://www.w3.org/TR/html401/html40.tgz"
S=${WORKDIR}
LICENSE="W3C"
SLOT="0"
KEYWORDS="~x86 ~s390"
IUSE=""
DEPEND="app-text/sgml-common"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-decl.diff
}

src_install() {
	insinto /usr/share/sgml/${PN}
	doins HTML4.cat HTML4.decl *.dtd *.ent
	insinto /etc/sgml
	dohtml *.html */*
}

sgml-catalog_cat_include "/etc/sgml/${PN}.cat" \
	"/usr/share/sgml/${PN}/HTML4.cat"
