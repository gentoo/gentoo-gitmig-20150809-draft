# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/portaltransforms/portaltransforms-1.0.4-r1.ebuild,v 1.7 2010/02/10 22:51:13 ssuominen Exp $

inherit zproduct

MY_PN="PortalTransforms"
MY_PV=1.0.4
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="MIME-type based transformations for Archetypes"
HOMEPAGE="http://www.sf.net/projects/archetypes"
SRC_URI="mirror://sourceforge/archetypes/${MY_P}.tgz"

LICENSE="GPL-1"
KEYWORDS="~ppc ~x86"

DEPEND_BOTH="dev-python/docutils
	www-client/lynx
	app-text/poppler"

RDEPEND="app-text/htmltidy
	app-text/wv
	dev-libs/libxslt
	app-text/xlhtml
	app-text/unrtf
	${DEPEND_BOTH}"

S=${WORKDIR}/${MY_P}/${MY_PN}

ZPROD_LIST="${MY_PN}"
MYDOC="${MYDOC} TODO README ChangeLog"

src_compile() {
	python setup.py build
}

src_install() {
	dodoc docs/*.rst
	dohtml docs/*.html
	DIR=`ls -d build/scripts*`
	S=${S}/build dobin ${DIR}/transform
	S=${S}/build/lib/Products zproduct_src_install all
	cp -a "${S}"/{Extensions,zope,www,skins} "${D}"/${ZP_DIR}/${PF}/${MY_PN}
	cp "${S}"/tool.gif "${D}"/${ZP_DIR}/${PF}/${MY_PN}
}
