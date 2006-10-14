# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/eterm/eterm-0.9.4.ebuild,v 1.2 2006/10/14 19:22:07 vapier Exp $

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
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
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
	use minimal || unpack Eterm-bg-${PV}.tar.gz
}

src_compile() {
	local mymmx
	use x86 \
		&& mymmx="$(use_enable mmx)" \
		|| mymmx="--disable-mmx"
	econf \
		$(use_enable escreen) \
		$(use_enable etwin) \
		--with-imlib \
		--enable-trans \
		${mymmx} \
		$(use_enable unicode multi-charset) \
		--with-delete=execute \
		--with-backspace=auto \
		|| die "conf failed"
	emake || die "make failed"
}

src_install() {
	make \
		TIC="tic -o ${D}/usr/share/terminfo" \
		DESTDIR="${D}" \
		install || die "install failed"
	dodoc ChangeLog README ReleaseNotes
	use escreen && dodoc doc/README.Escreen
	dodoc bg/README.backgrounds
}
