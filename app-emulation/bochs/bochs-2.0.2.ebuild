# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/bochs/bochs-2.0.2.ebuild,v 1.12 2004/01/10 14:56:58 bazik Exp $

inherit eutils

DESCRIPTION="a LGPL-ed pc emulator"
HOMEPAGE="http://bochs.sourceforge.net/"
SRC_URI="mirror://sourceforge/bochs/${P}.tar.gz
	 http://bochs.sourceforge.net/guestos/dlxlinux4.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc alpha sparc"
IUSE="sdl gtk"

DEPEND=">=sys-libs/glibc-2.1.3
	>=x11-base/xfree-4.0.1
	>=sys-apps/sed-4
	sdl? media-libs/libsdl
	gtk?  x11-libs/wxGTK"

src_unpack() {
	unpack ${A}
#	unpack ${P}.tar.gz
	cd ${S}
# 		-e 's:MAN_PAGE_1_LIST=bochs bximage bochs-dlx:MAN_PAGE_1_LIST=bochs bximage:'
	sed -i \
		-e "s:\$(WGET) \$(DLXLINUX_TAR_URL):cp ${DISTDIR}/dlxlinux4.tar.gz .:" \
		-e 's:BOCHSDIR=:BOCHSDIR=/usr/lib/bochs#:' \
		-e 's: $(BOCHSDIR): $(DESTDIR)$(BOCHSDIR):g' Makefile.in || \
			die "sed Makefile.in failed"
	epatch ${FILESDIR}/${P}-gcc3.patch || die
}

src_compile() {
	[ "$ARCH" == "x86" ] && myconf="--enable-idle-hack"
	myconf="${myconf} `use_with sdl`"
	myconf="${myconf} `use_with gtk wx`"

	./configure \
		--enable-fpu --enable-cdrom --enable-control-panel \
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
	#cleanup
	rm -rf ${D}/usr/share/bochs/{vga.pcf,install-x11-fonts,test-x11-fonts}
	rm -rf ${D}/usr/share/bochs/keymaps/CVS
	insinto /usr/X11R6/lib/X11/fonts/misc
	doins ${S}/font/vga.pcf
	gzip ${D}/usr/X11R6/lib/X11/fonts/misc/vga.pcf
	dodoc CHANGES CVS README TESTFORM.txt || die "dodoc failed"
}

pkg_postinst() {
	einfo "Updating the font index"
	mkfontdir /usr/X11R6/lib/X11/fonts/misc
	einfo "If you are running X please update the fontlist with:"
	einfo "# xset fp rehash"
}
