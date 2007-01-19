# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/eterm/eterm-0.9.3-r4.ebuild,v 1.10 2007/01/19 04:36:55 vapier Exp $

inherit eutils

MY_P=Eterm-${PV}
DESCRIPTION="A vt102 terminal emulator for X"
HOMEPAGE="http://www.eterm.org/"
SRC_URI="http://www.eterm.org/download/${MY_P}.tar.gz
	!minimal? ( http://www.eterm.org/download/Eterm-bg-${PV}.tar.gz )
	mirror://sourceforge/eterm/${MY_P}.tar.gz
	!minimal? ( mirror://sourceforge/eterm/Eterm-bg-${PV}.tar.gz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE="escreen etwin minimal mmx unicode"

DEPEND="|| ( ( x11-libs/libX11 x11-libs/libXmu x11-libs/libXt x11-libs/libICE x11-libs/libSM x11-proto/xextproto x11-proto/xproto ) virtual/x11 )
	>=x11-libs/libast-0.6.1
	media-libs/imlib2
	etwin? ( app-misc/twin )
	escreen? ( app-misc/screen )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd "${S}"
	epatch "${FILESDIR}"/${P}-pixmap-colmod.patch
	epatch "${FILESDIR}"/${P}-CARD64.patch #76324
	epatch "${FILESDIR}"/${P}-deadkeys.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch #92485
	use minimal || unpack Eterm-bg-${PV}.tar.gz
	sed -i 's:Tw/Tw_1\.h:Tw/Tw1.h:' src/libscream.c || die
}

src_compile() {
	export TIC="true"
	econf \
		$(use_enable escreen) \
		$(use_enable etwin) \
		--with-imlib \
		--enable-trans \
		$(use_enable mmx) \
		$(use_enable unicode multi-charset) \
		--with-delete=execute \
		--with-backspace=auto \
		|| die "conf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc ChangeLog README ReleaseNotes
	use escreen && dodoc doc/README.Escreen
	dodoc bg/README.backgrounds
}
