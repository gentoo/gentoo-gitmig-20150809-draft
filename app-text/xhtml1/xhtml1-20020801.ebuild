# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xhtml1/xhtml1-20020801.ebuild,v 1.4 2003/09/05 22:37:22 msterret Exp $

DESCRIPTION="DTDs for the eXtensible HyperText Markup Language 1.0"
HOMEPAGE="http://www.w3.org/TR/${PN}/"
SRC_URI="${HOMEPAGE}${PN}.tgz"
LICENSE="W3C"
SLOT="0"
KEYWORDS="x86"
DEPEND="app-text/sgml-common"

src_install() {
	insinto /usr/share/sgml/${PN}
	doins DTD/xhtml.soc DTD/*.dcl DTD/*.dtd DTD/*.ent
	insinto /etc/sgml
	dodoc *.pdf *.ps
	dohtml *.html *.png *.css
}

pkg_postinst() {
	if [ -x  "/usr/bin/install-catalog" ] && [ "$ROOT" = "/" ]
	then
		install-catalog --add /etc/sgml/${PN}.cat /usr/share/sgml/${PN}/xhtml.soc
	fi
}

pkg_prerm() {
	if [ -e /etc/sgml/${PN}.cat ]
	then
		install-catalog --remove /etc/sgml/${PN}.cat /usr/share/sgml/${PN}/xhtml.soc
	fi
}
