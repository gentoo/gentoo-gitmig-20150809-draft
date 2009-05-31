# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/atlantikdesigner/atlantikdesigner-3.5.10.ebuild,v 1.2 2009/05/31 21:06:47 nixnut Exp $
KMNAME=kdeaddons
EAPI="1"
inherit kde-meta

DESCRIPTION="Atlantik gameboard designer"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=kde-base/atlantik-${PV}:${SLOT}"
