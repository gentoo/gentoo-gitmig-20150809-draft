# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/portaltransforms/portaltransforms-1.0_alpha3.ebuild,v 1.2 2004/03/26 23:38:55 batlogg Exp $

inherit zproduct

MY_PN="PortalTransforms"
MY_PV="${PV/_alpha/a}"
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="MIME-type based transformations for Archetypes"
SRC_URI="mirror://sourceforge/archetypes/${MY_P}.tar.gz"
LICENSE="GPL-1"
KEYWORDS="~x86"
ZPROD_LIST="${MY_PN}"
MYDOC="${MYDOC} TODO README LICENSE.GPL ChangeLog"
DEPEND_BOTH="dev-python/docutils
		net-www/lynx
		app-text/pdftohtml"
RDEPEND="${RDEPEND}
		app-text/htmltidy
		app-text/wv
		dev-libs/libxslt
		app-text/xlhtml
		app-text/unrtf
		${DEPEND_BOTH}"
DEPEND="${DEPEND} =dev-lang/python-2.1* ${DEPEND_BOTH}"
S=${WORKDIR}/${MY_PN}

src_compile() {
	python2.1 setup.py build
}

src_install() {
	dodoc ChangeLog README TODO
	dodoc docs/*.rst
	dohtml docs/*.html
	S=${S}/build dobin build/scripts/transform
	S=${S}/build/lib/Products zproduct_src_install all
	into /
}
