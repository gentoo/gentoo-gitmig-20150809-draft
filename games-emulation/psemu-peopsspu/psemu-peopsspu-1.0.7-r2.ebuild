# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-peopsspu/psemu-peopsspu-1.0.7-r2.ebuild,v 1.3 2004/03/30 09:32:59 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="P.E.Op.S Sound Emulation (SPU) PSEmu Plugin"
HOMEPAGE="http://sourceforge.net/projects/peops/"
SRC_URI="mirror://sourceforge/peops/PeopsSpu${PV//./}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="alsa oss"

RDEPEND="alsa? ( media-libs/alsa-lib )
	app-arch/unzip
	=x11-libs/gtk+-1*"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	sys-devel/automake"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	cd src/linuxcfg
	tar -zxf spucfg.tar.gz
	( emake distclean && automake --add-missing ) || die "could not clean up"
	edos2unix `find -name '*.in' -o -name '*.am' -o -name '*.[ch]' -o -name 'config*'`
}

src_compile() {
	cd src
	sed -i \
		-e "s/-mpentium//" \
		-e "/^CCFLAGS3/s:=:= ${CFLAGS} :" Makefile \
			|| die "sed Makefile failed"
	if use oss || [ -z "`use oss``use alsa`" ] ; then
		emake clean || die
		emake USEALSA=FALSE || die
		mv libspu* ..
	fi
	if use alsa ; then
		emake clean || die
		emake USEALSA=TRUE || die
		mv libspu* ..
	fi

	cd linuxcfg
	econf || die
	emake || die "emake failed"
	mv src/spucfg src/cfgPeopsOSS
}

src_install() {
	exeinto ${GAMES_LIBDIR}/psemu/plugins
	doexe libspu*
	exeinto ${GAMES_LIBDIR}/psemu/cfg
	doexe cfgPeopsOSS
	insinto ${GAMES_LIBDIR}/psemu/cfg
	doins spuPeopsOSS.cfg
	dodoc src/*.txt *.txt
	prepgamesdirs
}
