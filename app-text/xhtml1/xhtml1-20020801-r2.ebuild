# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xhtml1/xhtml1-20020801-r2.ebuild,v 1.1 2004/11/06 13:19:44 usata Exp $

inherit sgml-catalog eutils

DESCRIPTION="DTDs for the eXtensible HyperText Markup Language 1.0"
HOMEPAGE="http://www.w3.org/TR/${PN}/"
SRC_URI="http://www.w3.org/TR/xhtml1/xhtml1.tgz"
LICENSE="W3C"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-text/sgml-common
	!dev-util/gtk-doc"

src_unpack() {
	unpack ${A}
	cd ${S}/DTD
	epatch ${FILESDIR}/${PN}-dtddecl.diff
}

src_install() {
	insinto /usr/share/sgml/${PN}
	doins DTD/xhtml.soc DTD/*.dcl DTD/*.dtd DTD/*.ent
	insinto /etc/sgml
	dodoc *.pdf *.ps
	dohtml *.html *.png *.css
}

sgml-catalog_cat_include "/etc/sgml/${PN}.cat" \
	"/usr/share/sgml/${PN}/xhtml.soc"
