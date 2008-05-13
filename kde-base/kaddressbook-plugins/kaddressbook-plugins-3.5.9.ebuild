# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaddressbook-plugins/kaddressbook-plugins-3.5.9.ebuild,v 1.6 2008/05/13 14:42:03 jer Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA=kaddressbook-plugins/
EAPI="1"
inherit kde-meta

DESCRIPTION="Plugins for KAB"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND="|| ( >=kde-base/kaddressbook-${PV}:${SLOT} >=kde-base/kdepim-${PV}:${SLOT} )"

RDEPEND="${DEPEND}"
