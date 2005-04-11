# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/gxemul/gxemul-0.3.1.ebuild,v 1.1 2005/04/11 21:50:17 kumba Exp $

inherit eutils

DESCRIPTION="A Machine Emulator, Mainly emulates MIPS, but supports other CPU types."
HOMEPAGE="http://gavare.se/gxemul/"
SRC_URI="http://gavare.se/gxemul/src/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~mips ~sparc ~x86"
IUSE="X cacheemu delays mips16"

DEPEND="X? ( virtual/x11 )"

src_compile() {
	cd ${S}
	local myconf=""

	# Patch to let gxemul's configure script pick
	# up mips64 cross-compilers
	epatch ${FILESDIR}/${P}-mips64-crosscc-check.patch

	# Based on USE, enable or disable some options
	use X || myconf="${myconf} --disable-x"
	use cacheemu && myconf="${myconf} --enable-caches"
	use delays && myconf="${myconf} --enable-delays"
	use mips16 && myconf="${myconf} --enable-mips16"

	echo -e ""
	einfo "Configuring with: ${myconf}"
	./configure ${myconf} || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	dobin gxemul || die "gxemul not found in ${S}"
	doman man/*.1
	dodoc BUGS HISTORY LICENSE README RELEASE TODO
	dohtml doc/*
}
