# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/bochs/bochs-2.1.ebuild,v 1.5 2004/10/31 05:04:57 vapier Exp $

inherit eutils

DESCRIPTION="a LGPL-ed pc emulator"
HOMEPAGE="http://bochs.sourceforge.net/"
SRC_URI="mirror://sourceforge/bochs/${P}.tar.gz
	 http://bochs.sourceforge.net/guestos/dlxlinux4.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"
IUSE="sdl gtk readline"

RDEPEND="virtual/libc
	virtual/x11
	sdl? ( media-libs/libsdl )
	gtk? ( x11-libs/wxGTK )
	readline? sys-libs/readline"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
#	unpack ${A}
	unpack ${P}.tar.gz
	cd ${S}
# 		-e 's:MAN_PAGE_1_LIST=bochs bximage bochs-dlx:MAN_PAGE_1_LIST=bochs bximage:'
	sed -i \
		-e "s:\$(WGET) \$(DLXLINUX_TAR_URL):cp ${DISTDIR}/dlxlinux4.tar.gz .:" \
		-e 's:BOCHSDIR=:BOCHSDIR=/usr/lib/bochs#:' \
		-e 's: $(BOCHSDIR): $(DESTDIR)$(BOCHSDIR):g' Makefile.in || \
			die "sed Makefile.in failed"
#	epatch ${FILESDIR}/${P}-gcc3.patch || die
}

src_compile() {
	[ "$ARCH" == "x86" ] \
		&& myconf="--enable-idle-hack --enable-fast-function-calls"
	myconf="${myconf} `use_with sdl`"
	myconf="${myconf} `use_with gtk wx`"
	myconf="${myconf} `use_enable readline`"

	./configure \
		--enable-fpu --enable-cdrom --enable-control-panel \
		--enable-usb --enable-pci --enable-mmx --enable-sse\
		--enable-cpu-level=6 \
		--enable-repeat-speedups --enable-guest2host-tlb \
		--enable-plugins --enable-debugger \
		--enable-ne2000 --enable-sb16=linux --enable-slowdown --prefix=/usr \
		--infodir=/usr/share/info --mandir=/usr/share/man --host=${CHOST} \
		--with-x11 $myconf || \
			die "configure failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install unpack_dlx || die "make install failed"
	#workaround
	make prefix=${D}/usr install_dlx

	dodoc CHANGES README TESTFORM.txt || die "dodoc failed"
}

pkg_postinst() {
	einfo "Updating the font index"
	mkfontdir /usr/X11R6/lib/X11/fonts/misc
	einfo "If you are running X please update the fontlist with:"
	einfo "# xset fp rehash"
}
