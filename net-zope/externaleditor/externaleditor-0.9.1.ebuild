# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/externaleditor/externaleditor-0.9.1.ebuild,v 1.1 2006/05/27 14:32:10 radek Exp $

inherit zproduct

MY_PN="ExternalEditor"
MY_P="${MY_PN}-${PV}-src"
DESCRIPTION="Allows you to use your favorite editor(s) from ZMI"
HOMEPAGE="http://plope.com/software/ExternalEditor/"
SRC_URI="${HOMEPAGE}/${MY_P}.tgz"

LICENSE="ZPL"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=net-zope/zopeedit-${PV}"

ZPROD_LIST="${MY_PN}"

S_ZPROD=${WORKDIR}/${MY_PN}
#S=${S_ZPROD}
MYDOC="*.txt ${MYDOC}"

src_unpack() {
	# this hack is needed for creating proper zope product directory
	# with only necessary files (looking from zope product standpoint )
	# while skipping unnecesary files from zopeedit package
	mkdir ${S_ZPROD}.tmp
	unpack ${MY_P}.tgz
	cd ${S_ZPROD}
	mv *.dtml __init__.py *.txt *.gif ${MY_PN}.py  ${S_ZPROD}.tmp
	cd ..
	rm -rf ${S_ZPROD}
	mkdir ${S_ZPROD}
	# this mv creates proper product directory in default location
	mv ${S_ZPROD}.tmp ${S_ZPROD}/${MY_PN}
}

src_install() {
	S="${S_ZPROD}" zproduct_src_install
}

pkg_postinst() {
	zproduct_pkg_postinst
	ewarn "To use the External Editor Zope Product you will need to manually"
	ewarn "configure the helper application(/usr/bin/zopeedit.py) for your"
	ewarn "browser. Read the documention in /usr/share/doc/${PF}/"
}
