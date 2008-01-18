# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkonq/libkonq-4.0.0.ebuild,v 1.1 2008/01/18 01:33:12 ingmar Exp $

EAPI="1"

KMNAME=kdebase
KMMODULE=apps/lib/konq
inherit kde4-meta

DESCRIPTION="The embeddable part of konqueror"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"
RESTRICT="test"

src_test() {
	sed -e "/konqpopupmenutest/s/^/#DONOTTEST /" \
		-i "${S}"/apps/lib/konq/tests/CMakeLists.txt
	kde4-base_src_test
}
