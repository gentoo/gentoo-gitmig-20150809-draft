# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xlsx2csv/xlsx2csv-0.12.ebuild,v 1.1 2011/02/06 03:14:27 radhermit Exp $

EAPI=4

DESCRIPTION="Convert MS Office xlsx files to CSV"
HOMEPAGE="https://github.com/dilshod/xlsx2csv"
SRC_URI="https://github.com/downloads/dilshod/${PN}/${P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="app-arch/unzip
	test? ( dev-lang/python[xml] )"
RDEPEND="dev-lang/python[xml]"

S="${WORKDIR}/${PN}"

src_test() {
	local failure=0
	for i in test/*.xlsx ; do
		echo -n "test: $i "
		./xlsx2csv.py "$i" | diff -u "test/$(basename "$i" .xlsx).csv" - >/dev/null
		if [[ $? -ne 0 ]] ; then
			echo "FAILED"
			failure=1
		else
			echo "PASSED"
		fi
	done
	[[ $failure -ne 0 ]] && die "tests failed"
}

src_install() {
	newbin xlsx2csv.py xlsx2csv
	dodoc CHANGELOG README
}
