# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-peopsspu/psemu-peopsspu-1.0.9.ebuild,v 1.2 2006/12/06 17:18:11 wolf31o2 Exp $

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
	sys-devel/automake"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	cd src
	sed -i \
		-e "s:-mpentium -O3 -ffast-math -fomit-frame-pointer:${CFLAGS}:" \
		Makefile \
		|| die "sed Makefile failed"

	cd linuxcfg
	tar -zxf spucfg.tar.gz || die "unpack linuxcfg"
	make maintainer-clean || die "distclean linuxcfg"
	rm -f {,src/}Makefile.in aclocal.m4 configure
	edos2unix `find -name '*.[ch]'` *.in
	aclocal && automake -a -c && autoconf || die "could not autotool"
}

src_compile() {
	cd src
	if use oss || ! use alsa; then
		make clean || die "oss clean"
		emake USEALSA=FALSE || die "oss build"
		mv libspu* ..
	fi
	if use alsa ; then
		make clean || die "alsa clean"
		emake USEALSA=TRUE || die "alsa build"
		mv libspu* ..
	fi

	cd linuxcfg
	econf || die
	emake || die "linuxcfg failed"
	mv src/spucfg src/cfgPeopsOSS
}

src_install() {
	exeinto ${GAMES_LIBDIR}/psemu/plugins
	doexe libspu* || die "doexe plugins"
	exeinto ${GAMES_LIBDIR}/psemu/cfg
	doexe cfgPeopsOSS || die "doexe cfg"
	insinto ${GAMES_LIBDIR}/psemu/cfg
	doins spuPeopsOSS.cfg
	dodoc src/*.txt *.txt
	prepgamesdirs
}
