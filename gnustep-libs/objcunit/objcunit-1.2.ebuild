# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/objcunit/objcunit-1.2.ebuild,v 1.5 2007/08/18 15:28:07 angelos Exp $

S=${WORKDIR}/ObjcUnit-1.2/ObjcUnit

inherit gnustep

DESCRIPTION="ObjcUnit: a unit testing framework for Obj-C on MacOSX and GNUstep"
HOMEPAGE="http://oops.se/objcunit/"
#SRC_URI="ftp://ftp.oops.se/pub/software/ObjcUnit/ObjcUnit-${PV}.tar.gz"
# note: we cannot take original upstream sources, as they need GNUstep
#       patches, which are included in below URL
SRC_URI="http://xanthippe.dyndns.org/Zipper/ObjcUnit-${PV}-GNUstep.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="IBM"
SLOT="0"

IUSE=""
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
