# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/airt/airt-0.4.ebuild,v 1.2 2005/01/26 01:59:40 dragonheart Exp $

inherit linux-mod toolchain-funcs

DESCRIPTION="AIRT(Advanced incident response tool) is a set of incident response assistant tools on linux platform."
HOMEPAGE="http://159.226.5.93/projects/airt.htm"
SRC_URI="http://159.226.5.93/projects/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86 -*"
IUSE=""
S=${WORKDIR}/${PN}
DEPEND="virtual/libc"

MODULE_NAMES="sock_hunter(:) process_hunter(:) mod_hunter(:) modumper(:${S}/mod_dumper)"
BUILD_PARAMS="KDIR=${KERNEL_DIR}"
BUILD_TARGETS="default"

src_unpack() {
	unpack ${A}
	sed -i -e "s|^CC.*|CC = $(tc-getCC) ${CFLAGS}|" -e "s/modumper:/default:/" \
		${S}/mod_dumper/Makefile
}

src_compile() {
	linux-mod_src_compile
	emake -C mod_dumper dismod || die
}


src_install() {
	linux-mod_src_install
	dosbin mod_dumper/dismod
	dosbin mod_dumper/dismod.pl
	dodoc CHANGELOG CHANGELOG.txt README.txt TODO
}

