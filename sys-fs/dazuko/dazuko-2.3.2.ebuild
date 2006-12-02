# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dazuko/dazuko-2.3.2.ebuild,v 1.2 2006/12/02 16:02:44 alonbl Exp $

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

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-2.3.1-suspend2.patch"
}

src_compile() {
	./configure \
		--without-dep \
		--kernelsrcdir="${KERNEL_DIR}" \
		--kernelobjdir="${KBUILD_OUTPUT}" \
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

