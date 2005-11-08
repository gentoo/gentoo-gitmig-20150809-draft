# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/xshipwars/xshipwars-2.4.7.ebuild,v 1.2 2005/11/08 04:56:09 vapier Exp $

inherit toolchain-funcs eutils games

MY_P=xsw-${PV}
DESCRIPTION="massively multi-player, ultra graphical, space-oriented gaming system designed exclusively for network play"
HOMEPAGE="http://wolfpack.twu.net/ShipWars/XShipWars/"
SRC_URI="http://wolfpack.twu.net/users/wolfpack/${MY_P}.tar.bz2
	http://wolfpack.twu.net/users/wolfpack/xsw-data-${PV}.tar.bz2
	http://wolfpack.twu.net/users/wolfpack/stimages-1.9.5.tar.bz2
	http://wolfpack.twu.net/users/wolfpack/stsounds-1.5.2.tar.bz2"

LICENSE="GPL-2 xshipwars"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="joystick yiff esd"

DEPEND="virtual/x11
	joystick? ( media-libs/libjsw )
	yiff? ( media-libs/yiff )
	esd? ( >=media-sound/esound-0.2.23 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-64bit-warnings.patch
	epatch "${FILESDIR}"/${P}-build.patch
#	epatch "${FILESDIR}"/${P}-missing-strlen-def.patch
	sed -i \
		-e "/^BINDIR/s:=.*:=${GAMES_BINDIR}:" \
		-e "/^DATADIR/s:=.*:=${GAMES_DATADIR}:" \
		*/Makefile.install.UNIX || die
}

src_compile() {
	local myconf=" \
		--disable-debug \
		--disable-arch-i486 \
		--disable-arch-i586 \
		--disable-arch-i686 \
		--disable-arch-pentiumpro \
		$(use_enable joystick libjsw) \
		--enable-X11 \
		--enable-libXpm \
		$(use_enable yiff Y2) \
		$(use_enable esd ESounD) \
	"
	# xsw uses --{en,dis}able=FEATURE syntax
	myconf=${myconf//able-/able=}

	local x
	for x in client monitor unvedit ; do #server
		echo ./configure.${x} Linux --prefix=${GAMES_PREFIX} ${myconf}
		./configure.${x} Linux --prefix=${GAMES_PREFIX} ${myconf} || die "configure ${x}"
		emake -j1 -f Makefile.${x} all || die "build ${x}"
	done
}

src_install() {
	local x
	for x in client monitor unvedit ; do #server
		make -f Makefile.${x} DESTDIR="${D}" install || die "install ${x}"
	done

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r "${WORKDIR}"/{etc,images,sounds} || die "doins data"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "Before playing, you should get a copy of the installed "
	einfo "global XShipWars client configuration file and copy it to "
	einfo "your home directory: "
	echo
	einfo "# mkdir ~/.shipwars/"
	einfo "# cd /usr/share/games/xshipwars/etc/ "
	einfo "# cp xshipwarsrc ~/.shipwars/xshipwarsrc "
	einfo "# cp universes ~/.shipwars/universes "
	echo
	einfo "You will probably need to edit the xshipwarsrc to fit your needs."
	echo
	einfo "Then type 'xsw &' to start the game"
	echo
}
