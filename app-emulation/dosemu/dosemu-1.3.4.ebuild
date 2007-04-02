# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/dosemu/dosemu-1.3.4.ebuild,v 1.1 2007/04/02 21:36:22 hanno Exp $

inherit flag-o-matic eutils autotools

P_FD=dosemu-freedos-b9r5a-bin
DESCRIPTION="DOS Emulator"
HOMEPAGE="http://www.dosemu.org/"
SRC_URI="mirror://sourceforge/dosemu/${P_FD}.tgz
	mirror://sourceforge/dosemu/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE="X svga gpm debug"

RDEPEND="X? (
	|| ( (
		x11-libs/libXxf86vm
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-proto/xf86dgaproto
		x11-apps/xset
		x11-apps/xlsfonts
		x11-apps/bdftopcf
		x11-apps/mkfontdir
	)
	virtual/x11
	) )
	svga? ( media-libs/svgalib )
	gpm? ( sys-libs/gpm )
	>=sys-libs/slang-1.4"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.57"

src_unpack() {
	unpack ${P}.tgz
	cd ${S}

	epatch ${FILESDIR}/dosemu-1.3.3-configure.ac.patch
	epatch ${FILESDIR}/dosemu-1.3.4-shm.diff
	epatch ${FILESDIR}/dosemu-1.3.4-slang2.diff
	epatch ${FILESDIR}/dosemu-compile-asm.diff

	eautoreconf || die "autoconf failed"
}

src_compile() {
	# Has problems with -O3 on some systems
	replace-flags -O[3-9] -O2

	# Fix compilation on hardened
	append-flags -fno-pic

	unset KERNEL

	econf `use_with X x` \
		`use_enable svga svgalib` \
		`use_enable debug` \
		`use_with gpm` \
		--with-fdtarball=${DISTDIR}/${P_FD}.tgz \
		--sysconfdir=/etc/dosemu/ \
		--with-docdir=/usr/share/doc/${PF} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	# Don't remove COPYING, see bug #137286
	dodoc Bugs ChangeLog COPYING NEWS THANKS
}
