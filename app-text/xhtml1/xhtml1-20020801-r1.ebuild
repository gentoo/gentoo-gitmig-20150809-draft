# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xhtml1/xhtml1-20020801-r1.ebuild,v 1.5 2004/02/29 18:10:26 aliz Exp $

inherit sgml-catalog

DESCRIPTION="DTDs for the eXtensible HyperText Markup Language 1.0"
HOMEPAGE="http://www.w3.org/TR/${PN}/"
SRC_URI="http://www.w3.org/TR/xhtml1/xhtml1.tgz"
LICENSE="W3C"
SLOT="0"
KEYWORDS="x86"
DEPEND="app-text/sgml-common
	!dev-util/gtk-doc"

src_install() {
	insinto /usr/share/sgml/${PN}
	doins DTD/xhtml.soc DTD/*.dcl DTD/*.dtd DTD/*.ent
	insinto /etc/sgml
	dodoc *.pdf *.ps
	dohtml *.html *.png *.css
}

sgml-catalog_cat_include "/etc/sgml/${PN}.cat" \
	"/usr/share/sgml/${PN}/xhtml.soc"
