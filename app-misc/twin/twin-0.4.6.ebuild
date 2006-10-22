# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/twin/twin-0.4.6.ebuild,v 1.12 2006/10/22 05:55:19 vapier Exp $

inherit eutils fixheadtails

DESCRIPTION="A text-mode window environment"
HOMEPAGE="http://twin.sourceforge.net/"
SRC_URI="mirror://sourceforge/twin/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE="X gtk ggi gpm"

RDEPEND="X? ( x11-libs/libXpm x11-libs/libX11 )
	ggi? ( >=media-libs/libggi-1.9 )
	gtk? ( =x11-libs/gtk+-1.2* )
	gpm? ( >=sys-libs/gpm-1.19.3 )
	>=sys-libs/ncurses-5.2"
DEPEND="${RDEPEND}
	X? ( x11-proto/xproto )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-autotools.patch
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-gcc.patch
	ht_fix_file configure
}

src_compile() {
	local myconf

	use X \
		&& myconf="--with-x --enable-hw-x11=yes"
	use ggi \
		&& myconf="${myconf} --enable-hw-ggi=yes" \
		|| myconf="${myconf} --enable-hw-ggi=no"
	use gtk \
		&& myconf="${myconf} --enable-tt-hw-gtk=yes" \
		|| myconf="${myconf} --enable-tt-hw-gtk=no"
	use gpm \
		&& myconf="${myconf} --enable-hw-tty-linux=yes" \
		|| myconf="${myconf} --enable-hw-tty-linux=no"
	econf \
		--enable-shlibs=yes \
		--enable-modules=yes \
		--enable-unicode=yes \
		--enable-socket=yes \
		--enable-socket-gz=yes \
		--enable-socket-pthreads=yes \
		--enable-socket-alien=yes \
		--enable-h2-tty-termcap=yes \
		--enable-term=yes \
		${myconf} \
		|| die
	emake -j1 || die
}

src_install() {
	emake install DESTDIR="${D}" || die

	if use X ; then
		insinto /usr/lib/X11/fonts/misc
		doins fonts/vga.pcf.gz
	fi

	rm -rf "${D}"/usr/share/twin/{BUGS,docs,COP*,READ*,Change*,INSTALL*}

	dodoc BUGS Change* README* TODO/TODO TODO/twin-thoughts
	doman docs/twin.1
	dodoc docs/*
	rm -f "${D}"/usr/share/doc/${PF}/twin.1*
}
