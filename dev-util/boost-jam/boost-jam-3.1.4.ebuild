# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/boost-jam/boost-jam-3.1.4.ebuild,v 1.1 2003/06/25 08:03:25 avenj Exp $

DESCRIPTION="Boost.Jam - an alternative to make based on Jam."
HOMEPAGE="http://www.boost.org/tools/build/jam_src/index.html"
SRC_URI="mirror://sourceforge/boost/boost-jam-${PV}.tgz"
LICENSE="as-is"
SLOT="0"

# When keywording for your arch, check the note in src_install
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_compile() {
	./build.sh
}

src_install() {
	# This is arch-specific: 

	use x86 && cd ${S}/bin.linuxx86

	dobin bjam jam mkjambase yyacc
}
