# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/xshipwars/xshipwars-2.6.1.ebuild,v 1.2 2010/10/08 10:53:01 tupone Exp $

EAPI=2
inherit eutils games

MY_P=xsw-${PV}
DESCRIPTION="massively multi-player, ultra graphical, space-oriented gaming system designed for network play"
HOMEPAGE="http://wolfsinger.com/~wolfpack/XShipWars/"
SRC_URI="http://wolfsinger.com/~wolfpack/XShipWars/${MY_P}.tar.bz2
	http://wolfsinger.com/~wolfpack/XShipWars/xsw-data-${PV}.tar.bz2
	mirror://gentoo/stimages-1.11.1.tar.bz2
	mirror://gentoo/stsounds-1.6.4.tar.bz2"

LICENSE="GPL-2 xshipwars"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="joystick yiff debug"

RDEPEND="x11-libs/libXpm
	joystick? ( media-libs/libjsw )
	yiff? ( media-libs/yiff )"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-64bit.patch \
		"${FILESDIR}"/${P}-ldflags.patch
	sed -i \
		-e "/^BINDIR/s:=.*:=${GAMES_BINDIR}:" \
		-e "/^DATADIR/s:=.*:=${GAMES_DATADIR}:" \
		*/Makefile.install.UNIX || die
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		client/xsw.h || die
}

src_configure() {
	:
}

src_compile() {
	local myconf=" \
		--disable-arch-i486 \
		--disable-arch-i586 \
		--disable-arch-i686 \
		--disable-arch-pentiumpro \
		--disable-ESounD \
		$(use_enable joystick libjsw) \
		$(use_enable debug) \
		--enable-X11 \
		--enable-libXpm \
		$(use_enable yiff Y2) \
	"
	# xsw uses --{en,dis}able=FEATURE syntax
	myconf=${myconf//able-/able=}

	local x
	for x in client monitor unvedit ; do #server
		./configure.${x} Linux --prefix="${GAMES_PREFIX}" ${myconf} || die
		emake -j1 -f Makefile.${x} all || die
	done
}

src_install() {
	local x
	for x in client monitor unvedit ; do #server
		emake -j1 DESTDIR="${D}" -f Makefile.${x} install || die
	done

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r "${WORKDIR}"/{etc,images,sounds} || die

	dodoc AUTHORS CREDITS README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "Before playing, you should get a copy of the installed "
	elog "global XShipWars client configuration file and copy it to "
	elog "your home directory:"
	echo
	elog "# mkdir ~/.shipwars/"
	elog "# cd /usr/share/games/xshipwars/etc/"
	elog "# cp xsw.ini ~/.shipwars/"
	elog "# cp universes.ini ~/.shipwars"
	echo
	elog "You will probably need to edit xsw.ini to fit your needs."
	echo
	elog "Then type 'xsw &' to start the game"
	echo
	elog "Type 'monitor &' to start the Universe Monitor"
	elog "Type 'unvedit &' to start the Universe Editor"
}
