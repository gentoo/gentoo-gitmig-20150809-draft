# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/bochs/bochs-2.2.5-r1.ebuild,v 1.2 2006/02/05 18:34:18 lu_zero Exp $

inherit eutils wxwidgets

DESCRIPTION="a LGPL-ed pc emulator"
HOMEPAGE="http://bochs.sourceforge.net/"
SRC_URI="mirror://sourceforge/bochs/${P}.tar.gz
	 http://bochs.sourceforge.net/guestos/dlxlinux4.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ~sparc ~x86"
IUSE="debugger readline sdl wxwindows X ncurses vnc"

RDEPEND="virtual/libc
	X? || ( virtual/x11
			( 	x11-libs/libICE
				x11-libs/libSM
				x11-libs/libX11
				x11-libs/libXpm ) )
	sdl? ( media-libs/libsdl )
	wxwindows? ( >=x11-libs/wxGTK-2.6 )
	readline? ( sys-libs/readline )
	ncurses? ( sys-libs/ncurses )"

DEPEND="${RDEPEND}
	X? || ( virtual/x11
			x11-proto/xproto )
	>=sys-apps/sed-4
	>=app-text/opensp-1.5"

src_unpack() {
#	unpack ${A}
	unpack ${P}.tar.gz
	cd ${S}
# 		-e 's:MAN_PAGE_1_LIST=bochs bximage bochs-dlx:MAN_PAGE_1_LIST=bochs bximage:'
	sed -i \
		-e "s:\$(WGET) \$(DLXLINUX_TAR_URL):cp ${DISTDIR}/dlxlinux4.tar.gz .:" \
		-e "s:BOCHSDIR=:BOCHSDIR=/usr/$(get_libdir)/bochs#:" \
		-e 's: $(BOCHSDIR): $(DESTDIR)$(BOCHSDIR):g' Makefile.in || \
			die "sed Makefile.in failed"

# Make it use the correct path to gtk-2
	sed -i -e "s:/opt/gnome:/usr:" configure
# Fix some bad coding for gcc-4.1 compliance
	sed -i -e "s:\#ifndef PARANOID:\#if 0:" iodev/hdimage.h
}

src_compile() {
	export WX_GTK_VER=2.6

	use wxwindows && \
		need-wxwidgets gtk2

	[[ "$ARCH" == "x86" ]] \
		&& myconf="--enable-idle-hack --enable-fast-function-calls"
	myconf="${myconf} `use_with sdl`"
	myconf="${myconf} `use_enable readline`"
	use wxwindows && \
		myconf="${myconf} --with-wx"
	use wxwindows || \
		myconf="${myconf} --without-wx"
	use debugger && \
		myconf="$myconf --enable-debugger --enable-disasm \
				--enable-x86-debugger --enable-iodebug"
	use vnc && \
		myconf="$myconf --with-rfb"

	use X && \
		myconf="$myconf --with-x11"

	use ncurses && \
		myconf="$myconf --with-term"

	if ! use X && ! use ncurses && ! use vnc && ! use sdl
	then
		myconf="$myconf --with-nogui"
	fi

	./configure \
		--enable-fpu --enable-cdrom \
		--enable-usb --enable-pci \
		--enable-mmx --enable-sse=2 --enable-3dnow \
		--enable-cpu-level=6 --enable-vbe \
		--enable-repeat-speedups --enable-guest2host-tlb \
		--enable-plugins \
		--enable-ignore-bad-msr \
		--enable-ne2000 --enable-sb16=linux --enable-slowdown --prefix=/usr \
		--infodir=/usr/share/info --mandir=/usr/share/man --host=${CHOST} \
		--libdir=/usr/$(get_libdir) \
		${myconf} || die "configure failed"


	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install unpack_dlx || die "make install failed"
	#workaround
	make prefix=${D}/usr install_dlx

	dodoc CHANGES README TESTFORM.txt || die "dodoc failed"
}
