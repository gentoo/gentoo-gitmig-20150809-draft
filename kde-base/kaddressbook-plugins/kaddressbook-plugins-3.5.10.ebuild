# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaddressbook-plugins/kaddressbook-plugins-3.5.10.ebuild,v 1.4 2009/06/06 13:21:30 maekke Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA=kaddressbook-plugins/
EAPI="1"
inherit kde-meta

DESCRIPTION="Plugins for KAB"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="|| ( >=kde-base/kaddressbook-${PV}:${SLOT} >=kde-base/kdepim-${PV}:${SLOT} )"

RDEPEND="${DEPEND}"
