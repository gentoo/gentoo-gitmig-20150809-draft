# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/darwinia-demo/darwinia-demo-1.3.0.ebuild,v 1.1 2005/11/14 03:35:47 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Darwinia, the hyped indie game of the year. By the Uplink creators."
HOMEPAGE="http://www.darwinia.co.uk/downloads/demo_linux.html"
SRC_URI="http://www.introversion.co.uk/darwinia/downloads/${PN}2-${PV}.sh"

LICENSE="Introversion"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="nostrip"

S=${WORKDIR}
dir=${GAMES_PREFIX_OPT}/${PN}

pkg_setup() {
	check_license Introversion
	games_pkg_setup
}

src_unpack() {
	unpack_makeself
}

src_install() {
	exeinto "${dir}/lib"
	doexe lib/lib{gcc_s.so.1,SDL-1.2.so.0,vorbis{.so.0,file.so.3},ogg.so.0} \
		|| die "Copying libraries"
	doexe lib/{darwinia.bin.x86,open-www.sh} || die "copying executables"
	insinto "${dir}/lib"
	doins lib/{sounds,main,language}.dat || die "copying data files"
	insinto "${dir}"
	dodoc README || die "copying docs"

	exeinto "${dir}"
	doexe bin/Linux/x86/darwinia || die "couldn't do exe"

	games_make_wrapper darwinia-demo ./darwinia "${dir}" "${dir}"
	newicon darwinian.png darwinia.png
	make_desktop_entry darwinia-demo "Darwinia" darwinia.png
	prepgamesdirs
}
