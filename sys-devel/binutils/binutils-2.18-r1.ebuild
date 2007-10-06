# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.18-r1.ebuild,v 1.3 2007/10/06 23:17:08 vapier Exp $

PATCHVER="1.4"
ELF2FLT_VER=""
inherit toolchain-binutils

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"

src_unpack() {
	toolchain-binutils_src_unpack
	# disable regeneration of info pages #193364
	touch "${S}"/bfd/elf.c
}
