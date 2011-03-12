# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/nxml-docbook5-schemas/nxml-docbook5-schemas-20080922.ebuild,v 1.2 2011/03/12 14:41:55 ulm Exp $

NEED_EMACS=23
inherit elisp

DESCRIPTION="Add support for DocBook 5 schemas to NXML"
HOMEPAGE="http://www.docbook.org/schemas/5x.html"
SRC_URI="http://www.docbook.org/xml/5.0/rng/docbookxi.rnc"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE=60${PN}-gentoo.el

src_compile() { :; }

src_install() {
	insinto ${SITEETC}/${PN}
	doins "${FILESDIR}"/schemas.xml "${DISTDIR}"/docbookxi.rnc || die "install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}
