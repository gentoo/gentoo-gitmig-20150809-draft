# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zwiki/zwiki-0.37.ebuild,v 1.3 2006/01/27 02:54:22 vapier Exp $

inherit zproduct

DESCRIPTION="A zope wiki-clone for easy-to-edit collaborative websites"
HOMEPAGE="http://zwiki.org"
SRC_URI="${HOMEPAGE}/releases/ZWiki-${PV}.0.tgz"

LICENSE="GPL-2"
KEYWORDS="~ppc x86"

ZPROD_LIST="ZWiki"
MYDOC="ChangeLog ${MYDOC}"
