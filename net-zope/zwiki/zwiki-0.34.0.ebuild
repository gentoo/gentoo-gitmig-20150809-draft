# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zwiki/zwiki-0.34.0.ebuild,v 1.3 2004/10/18 12:34:01 dholm Exp $

inherit zproduct

DESCRIPTION="A zope wiki-clone for easy-to-edit collaborative websites."
HOMEPAGE="http://zwiki.org"
SRC_URI="${HOMEPAGE}/releases/ZWiki-${PV}.tgz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

ZPROD_LIST="ZWiki"
MYDOC="ChangeLog GPL.txt ${MYDOC}"

IUSE=""
