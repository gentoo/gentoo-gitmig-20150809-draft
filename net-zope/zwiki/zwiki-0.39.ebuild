# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zwiki/zwiki-0.39.ebuild,v 1.1 2005/03/26 01:38:29 radek Exp $

inherit zproduct

DESCRIPTION="A zope wiki-clone for easy-to-edit collaborative websites."
HOMEPAGE="http://zwiki.org"
SRC_URI="${HOMEPAGE}/releases/ZWiki-${PV}.0.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

ZPROD_LIST="ZWiki"
MYDOC="ChangeLog GPL.txt ${MYDOC}"

IUSE=""
