# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/gxemul/gxemul-0.4.2.ebuild,v 1.1 2006/10/20 20:05:11 drizzt Exp $

inherit eutils

DESCRIPTION="A Machine Emulator, Mainly emulates MIPS, but supports other CPU types."
HOMEPAGE="http://gavare.se/gxemul/"
SRC_URI="http://gavare.se/gxemul/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~sparc ~x86 ~ppc"
IUSE="X"

RDEPEND="|| ( ( x11-libs/libX11
				x11-libs/libXaw
				x11-libs/libXdmcp
				)
			virtual/x11 )"

DEPEND="${RDEPEND}
		|| ( x11-proto/xproto virtual/x11 )"

src_compile() {
	local myconf=""

	use X || myconf="${myconf} --disable-x"

	einfo "Configuring with: ${myconf}"
	./configure ${myconf} || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	dobin gxemul || die "gxemul not found in ${S}"
	doman man/gxemul.1
	dodoc HISTORY LICENSE README RELEASE TODO
	dohtml doc/*
}
