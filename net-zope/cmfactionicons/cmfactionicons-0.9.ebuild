# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfactionicons/cmfactionicons-0.9.ebuild,v 1.5 2004/09/24 20:57:20 batlogg Exp $

inherit zproduct

MY_PN=CMFActionIcons
S="${WORKDIR}/${MY_PN}-${PV}"

DESCRIPTION="CMFActionIcons: icon mapping tool, factored for reuse."
HOMEPAGE="http://zope.org/Members/tseaver/CMFActionIcons/"
SRC_URI="http://zope.org/Members/tseaver/${MY_PN}/${MY_PN}-${PV}/${MY_PN}-${PV}.tar.gz"
LICENSE="ZPL"
KEYWORDS="x86 ppc"

ZPROD_LIST="CMFActionIcons"
