# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dazuko/dazuko-2.2.0.ebuild,v 1.1 2006/02/19 10:59:45 wschlich Exp $

inherit linux-mod eutils

DESCRIPTION="Linux kernel module and interface providing file access control"
MY_P="${P/_/-}" # for -preN versions
SRC_URI="http://www.dazuko.org/files/${MY_P}.tar.gz"
HOMEPAGE="http://www.dazuko.org"
LICENSE="GPL-2 BSD"
# use full kernel version as SLOT, preventing removal of dazuko
# modules for previously used kernels
SLOT="${KV_FULL:-0}"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=">=virtual/linux-sources-2.2"
S="${WORKDIR}/${MY_P}"

# kernel settings
CONFIG_CHECK="SECURITY_CAPABILITIES"
MODULE_NAMES="dazuko(misc:)"
BUILD_TARGETS="dummy_rule"

# TODO add 'example' USE flag, install example source code

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	./configure \
		--kernelsrcdir="${KERNEL_DIR}" \
		|| die "configure failed"
	convert_to_m Makefile
	linux-mod_src_compile

	cd library && emake && cd ..
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
#	dodoc LICENSE.BSD
#	dodoc LICENSE.GPL
}

