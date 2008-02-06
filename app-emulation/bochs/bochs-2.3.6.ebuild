# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/bochs/bochs-2.3.6.ebuild,v 1.1 2008/02/06 23:12:29 lu_zero Exp $

inherit eutils wxwidgets autotools

DESCRIPTION="a LGPL-ed pc emulator"
HOMEPAGE="http://bochs.sourceforge.net/"
SRC_URI="mirror://sourceforge/bochs/${P}.tar.gz
		http://bochs.sourceforge.net/guestos/dlxlinux4.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="X debugger readline mmx sse usb 3dnow wxwindows svga sdl ncurses vnc acpi"

RDEPEND="virtual/libc
	X? ( x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXpm )
	sdl? ( media-libs/libsdl )
	svga? ( media-libs/svgalib )
	wxwindows? ( =x11-libs/wxGTK-2.6* )
	readline? ( sys-libs/readline )
	ncurses? ( sys-libs/ncurses )"

DEPEND="${RDEPEND}
	X? ( x11-proto/xproto )
	>=sys-apps/sed-4
	>=app-text/opensp-1.5"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}"

	# we already downloaded dlxlinux4.tar.gz so let the Makefile cp it instead
	# of downloading it again
	sed -i \
		-e "s:\$(WGET) \$(DLXLINUX_TAR_URL):cp ${DISTDIR}/dlxlinux4.tar.gz .:" \
		Makefile.in || \
		die "sed Makefile.in failed"

	# Make sure wxwindows 2.6 is used in case both 2.6 and 2.4 are installed
	sed -i -e "s:wx-config:wx-config-2.6:" configure.in
	eautoconf
}

src_compile() {
	export WX_GTK_VER=2.6

	use wxwindows && \
		need-wxwidgets gtk2

	[[ "$ARCH" == "x86" ]] \
		&& myconf="--enable-idle-hack --enable-fast-function-calls"

	[[ "$ARCH" == "amd64" ]] \
	    && myconf="--enable-x86-64"

	use wxwindows && \
		myconf="${myconf} --with-wx"
	use wxwindows || \
		myconf="${myconf} --without-wx"

	use vnc && \
		myconf="${myconf} --with-rfb"

	use X && \
		myconf="${myconf} --with-x11"

	use ncurses && \
		myconf="${myconf} --with-term"

	if ! use X && ! use ncurses && ! use vnc && ! use sdl
	then
		myconf="${myconf} --with-nogui"
	fi

	# --enable-all-optimizations causes bus error on sparc :(
	[[ "$ARCH" != "sparc" ]] \
		&& myconf="${myconf} --enable-all-optimizations"

	econf \
		--prefix=/usr \
		--enable-ne2000 \
		--enable-sb16=linux \
		--enable-plugins \
		--enable-cdrom \
		--enable-pci \
		$(use_enable usb) \
		$(use_enable sse) \
		$(use_enable 3dnow) \
		$(use_enable readline) \
		$(use_enable debugger) \
		$(use_with X) \
		$(use_with sdl) \
		$(use_with svga) \
		$(use_with acpi) \
		${myconf} || \
		die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install unpack_dlx || die "make install failed"

	# workaround
	make prefix="${D}/usr" install_dlx

	dodoc \
		CHANGES \
		PARAM_TREE.txt \
		README \
		README-plugins \
		TESTFORM.txt \
		TODO || \
		die "doco failed"

	if [ use vnc ]
	then
		dodoc README.rfb || die "dodoc failed"
	fi

	if [ use wxwindows ]
	then
		dodoc README-wxWindows || die "dodoc failed"
	fi
}
