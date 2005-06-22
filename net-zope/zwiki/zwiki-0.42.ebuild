# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zwiki/zwiki-0.42.ebuild,v 1.2 2005/06/22 02:02:55 weeve Exp $

inherit zproduct

DESCRIPTION="A zope wiki-clone for easy-to-edit collaborative websites."
HOMEPAGE="http://zwiki.org"
SRC_URI="${HOMEPAGE}/releases/ZWiki-${PV}.0.tgz"

LICENSE="GPL-2"
KEYWORDS="~ppc ~sparc ~x86"

ZPROD_LIST="ZWiki"
MYDOC="CHANGES.txt LICENSE.txt README.txt GPL.txt ${MYDOC}"

IUSE=""
