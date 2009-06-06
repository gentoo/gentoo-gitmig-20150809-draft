# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kicker-applets/kicker-applets-3.5.10.ebuild,v 1.4 2009/06/06 12:15:32 maekke Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kicker-applets doc/kicker-applets"
EAPI="1"
inherit kde-meta

DESCRIPTION="kicker applets"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="|| ( >=kde-base/kicker-${PV}:${SLOT} >=kde-base/kdebase-${PV}:${SLOT} )"

RDEPEND="${DEPEND}"

src_compile() {
	myconf="--without-xmms"
	kde-meta_src_compile
}
