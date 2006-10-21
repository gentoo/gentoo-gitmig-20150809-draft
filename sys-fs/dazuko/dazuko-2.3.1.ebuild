# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dazuko/dazuko-2.3.1.ebuild,v 1.4 2006/10/21 19:48:07 kloeri Exp $

inherit linux-mod

DESCRIPTION="Linux kernel module and interface providing file access control"
MY_P="${P/_/-}" # for -preN versions
SRC_URI="http://www.dazuko.org/files/${MY_P}.tar.gz"
HOMEPAGE="http://www.dazuko.org"
LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND=">=virtual/linux-sources-2.2"
S="${WORKDIR}/${MY_P}"

# kernel settings
CONFIG_CHECK="SECURITY_CAPABILITIES"
MODULE_NAMES="dazuko(misc:)"
BUILD_TARGETS="dummy_rule"

src_compile() {
	cd "${S}"

	./configure \
		--without-dep \
		--kernelsrcdir="${KERNEL_DIR}" \
		|| die "configure failed"
	convert_to_m Makefile
	linux-mod_src_compile

	cd library
	emake || die
	cd ..
}

src_install() {
	linux-mod_src_install

	dolib.a library/libdazuko.a
	insinto /usr/include
	doins dazukoio.h

	dodoc COPYING
	dodoc README
	dodoc README.linux26
	dodoc README.trusted
}

