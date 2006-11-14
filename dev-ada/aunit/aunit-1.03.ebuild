# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/aunit/aunit-1.03.ebuild,v 1.1 2006/11/14 13:57:53 george Exp $

inherit gnat

IUSE=""

DESCRIPTION="Aunit, Ada unit testing framework"
SRC_URI="https://libre2.adacore.com/aunit/${P}p-src.tgz"
HOMEPAGE="https://libre2.adacore.com/aunit/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="virtual/gnat"

S="${WORKDIR}/AUnit"

lib_compile() {
	# nothing to be done
	:
}

lib_install() {
	# nothing to be done
	:
}

src_install () {
	dodir ${AdalibSpecsDir}/${PN}
	insinto ${AdalibSpecsDir}/${PN}
	doins aunit/*/*.ad?

	dodir ${AdalibDataDir}/${PN}/template
	insinto ${AdalibDataDir}/${PN}/template
	doins template/*.ad?

	dodir ${AdalibDataDir}/${PN}/test
	insinto ${AdalibDataDir}/${PN}/test
	doins test/*.ad?

	#set up environment
	echo "ADA_INCLUDE_PATH=/usr/include/ada/${PN}" > ${LibEnv}

	gnat_src_install

	# remove empty dirs - no objects needed to be built
	rm -rf ${D}/usr/lib

	dodoc COPYING README
	dohtml AUnit.html
}
