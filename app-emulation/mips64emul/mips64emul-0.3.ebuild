# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/mips64emul/mips64emul-0.3.ebuild,v 1.1 2005/03/16 01:25:09 vapier Exp $

inherit eutils

DESCRIPTION="MIPS Machine Emulator, Emulates many machines/CPUs/OSes"
HOMEPAGE="http://gavare.se/gxemul/"
SRC_URI="http://gavare.se/gxemul/src/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~mips ~sparc ~x86"
IUSE="X cacheemu delays mips16"

DEPEND="X? ( virtual/x11 )"

src_compile() {
	local myconf=""
	use X || myconf="${myconf} --disable-x"
	use cacheemu && myconf="${myconf} --enable-caches"
	use delays && myconf="${myconf} --enable-delays"
	use mips16 && myconf="${myconf} --enable-mips16"
	echo "./configure ${myconf}"
	./configure ${myconf} || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	dobin mips64emul || die "dobin"
	doman man/*.1
	dodoc BUGS HISTORY README RELEASE TODO
	dohtml doc/*
}
