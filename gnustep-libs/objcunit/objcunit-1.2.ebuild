# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/objcunit/objcunit-1.2.ebuild,v 1.1 2004/11/14 20:32:41 fafhrd Exp $

S=${WORKDIR}/ObjcUnit-1.2/ObjcUnit

inherit gnustep

DESCRIPTION="ObjcUnit is a unit testing framework for Objective-C on Mac OS X and GNUstep"
HOMEPAGE="http://oops.se/objcunit/"
#HOMEPAGE="http://xanthippe.dyndns.org/Zipper/"
SRC_URI="http://xanthippe.dyndns.org/Zipper/ObjcUnit-${PV}-GNUstep.tar.gz"

KEYWORDS="~ppc"
LICENSE="IBM"
SLOT="0"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "System"

src_install() {
	egnustep_env
	egnustep_install || die
	if use doc ; then
		egnustep_env
		egnustep_doc || die
	fi
	egnustep_package_config
	dosym `egnustep_install_domain`/Library/Frameworks/ObjcUnit.framework/Headers `egnustep_install_domain`/Library/Headers/ObjcUnit
}

