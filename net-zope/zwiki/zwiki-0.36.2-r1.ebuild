# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zwiki/zwiki-0.36.2-r1.ebuild,v 1.2 2004/12/21 07:50:18 radek Exp $

inherit zproduct eutils

DESCRIPTION="A zope wiki-clone for easy-to-edit collaborative websites."
HOMEPAGE="http://zwiki.org"
SRC_URI="${HOMEPAGE}/releases/ZWiki-${PV}.tgz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

ZPROD_LIST="ZWiki"
MYDOC="ChangeLog GPL.txt ${MYDOC}"

IUSE=""


src_unpack() {
	unpack ${A}
	cd ${S}/${ZPROD_LIST}
	epatch ${FILESDIR}/${PF}_xss.patch
}
