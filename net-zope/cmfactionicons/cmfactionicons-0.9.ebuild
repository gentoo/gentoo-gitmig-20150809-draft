# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfactionicons/cmfactionicons-0.9.ebuild,v 1.1 2004/01/19 13:27:22 lanius Exp $

inherit zproduct

MY_PN=CMFActionIcons
S="${WORKDIR}/${MY_PN}-${PV}"

DESCRIPTION="CMFActionIcons: icon mapping tool, factored for reuse."
HOMEPAGE="http://zope.org/Members/tseaver/CMFActionIcons/"
SRC_URI="http://zope.org/Members/tseaver/${MY_PN}/${MY_PN}-${PV}/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"

ZPROD_LIST="CMFActionIcons"
