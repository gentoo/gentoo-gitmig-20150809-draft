# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-compat/emul-linux-x86-compat-1.0.ebuild,v 1.2 2004/08/29 03:45:50 lv Exp $

DESCRIPTION="emul-linux-x86 version of lib-compat, with the addition of a 32bit libgcc_s and the libstdc++ versions provided by gcc 3.3 and 3.4 for non-multilib systems."
SRC_URI="http://dev.gentoo.org/~lv/emul-linux-x86-compat-1.0.tar.bz2"
HOMEPAGE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
IUSE=""

# stop confusing portage 0.o
S=${WORKDIR}

DEPEND="virtual/libc
	>=app-emulation/emul-linux-x86-glibc-1.0"

src_install() {
	mkdir -p ${D}
	# everything should already be in the right place :)
	cp -Rpvf ${WORKDIR}/* ${D}/
}
