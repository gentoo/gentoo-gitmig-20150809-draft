# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zwiki/zwiki-0.17.0.ebuild,v 1.4 2003/06/21 02:58:24 kutsuya Exp $

inherit zproduct

DESCRIPTION="A zope wiki-clone for easy-to-edit collaborative websites."
HOMEPAGE="http://zwiki.org/"
SRC_URI="${HOMEPAGE}/releases/ZWiki-${PV}.tgz"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

ZPROD_LIST="ZWiki"
MYDOC="ChangeLog GPL.txt ${MYDOC}"