# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libconfig/libconfig-1.4.7.ebuild,v 1.7 2011/08/11 02:53:16 zmedico Exp $

EAPI="2"

inherit autotools-utils

DESCRIPTION="Libconfig is a simple library for manipulating structured configuration files"
HOMEPAGE="http://www.hyperrealm.com/libconfig/libconfig.html"
SRC_URI="http://www.hyperrealm.com/libconfig/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 ~sparc x86 ~x86-linux"
IUSE="examples static-libs"

DEPEND="
	sys-devel/libtool
	sys-devel/bison"
RDEPEND=""

src_configure() {
	# --disable-examples does not actually prevent examples from being built
	# but let's set it anyway
	econf $(use_enable static-libs static) --disable-examples
}

src_test() {
	# It responds to check but that does not work as intended
	emake test || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	use static-libs || remove_libtool_files
	if use examples; then
		local dir
		for dir in examples/c examples/c++; do
			insinto /usr/share/doc/${PF}/${dir}
			doins ${dir}/* || die
		done
	fi
}
