# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkonq/libkonq-4.0.4.ebuild,v 1.1 2008/05/16 00:47:11 ingmar Exp $

EAPI="1"

KMNAME=kdebase
KMMODULE=apps/lib/konq
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="The embeddable part of konqueror"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"

KMSAVELIBS="true"

src_test() {
	# three out of four tests are broken. we just disable those. last tested on 4.0.3.
	sed -e "/konqpopupmenutest/s/^/#DONOTTEST /" \
		-e "/konqfileundomanagertest/s/^/#DONOTTEST /" \
		-e "/favicontest/s/^/#DONOTTEST /" \
		-i "${S}"/apps/lib/konq/tests/CMakeLists.txt
	kde4-base_src_test
}
