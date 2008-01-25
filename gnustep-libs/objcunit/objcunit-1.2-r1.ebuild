# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/objcunit/objcunit-1.2-r1.ebuild,v 1.2 2008/01/25 17:23:41 opfer Exp $

S=${WORKDIR}/ObjcUnit-1.2/ObjcUnit

inherit gnustep-2

DESCRIPTION="ObjcUnit: a unit testing framework for Obj-C on MacOSX and GNUstep"
HOMEPAGE="http://oops.se/objcunit/"
#SRC_URI="ftp://ftp.oops.se/pub/software/ObjcUnit/ObjcUnit-${PV}.tar.gz"
# note: we cannot take original upstream sources, as they need GNUstep
#       patches, which are included in below URL
SRC_URI="http://xanthippe.dyndns.org/Zipper/ObjcUnit-${PV}-GNUstep.tar.gz"

KEYWORDS="~amd64 ~ppc x86"
LICENSE="IBM"
SLOT="0"

src_install() {
	gnustep-base_src_install
	dosym ${GNUSTEP_SYSTEM_LIBRARY}/Frameworks/ObjcUnit.framework/Headers ${GNUSTEP_SYSTEM_LIBRARY}/Headers/ObjcUnit
}
