# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-demo/quake3-demo-1.11.ebuild,v 1.6 2004/02/20 06:40:07 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="Quake III Arena - Demo version"
HOMEPAGE="http://www.idsoftware.com/games/quake/quake3-arena/"
SRC_URI="ftp://ftp.idsoftware.com/idstuff/quake3/linux/linuxq3ademo-${PV}-6.x86.gz.sh
	ftp://3dgamers.in-span.net/pub/3dgamers3/games/quake3arena/linuxq3ademo-${PV}-6.x86.gz.sh
	ftp://ftp.bluesnews.com/idstuff/quake3/linux/linuxq3ademo-${PV}-6.x86.gz.sh"

LICENSE="Q3AEULA"
SLOT="0"
KEYWORDS="-* x86"
IUSE="opengl dedicated 3dfx"

DEPEND=""
RDEPEND="dedicated? ( app-misc/screen )
	!dedicated? ( virtual/opengl )
	opengl? ( virtual/opengl )"

S=${WORKDIR}

pkg_setup() {
	check_license
	games_pkg_setup
}

src_unpack() {
	unpack_makeself
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	cp -rf Help ${D}/${dir}/
	cp -rf demoq3 ${D}/${dir}/

	exeinto ${dir}
	newexe bin/x86/glibc-2.0/q3ded q3ded.x86
	newexe bin/x86/glibc-2.0/q3demo q3demo.x86
	use 3dfx && doexe bin/x86/glibc-2.0/libMesaVoodooGL.so*
	#use opengl && dosym /usr/lib/libGL.so ${dir}/libGL.so

	doexe ${FILESDIR}/{q3demo,q3demo-ded}
	dodir ${GAMES_BINDIR}
	dosym ${dir}/q3demo ${GAMES_BINDIR}/q3demo
	dosym ${dir}/q3ded-demo ${GAMES_BINDIR}/q3demo-ded
	dosed "s:GENTOO_DIR:${dir}:" ${dir}/q3demo
	dosed "s:GENTOO_DIR:${dir}:" ${dir}/q3demo-ded

	insinto ${dir}
	doins README icon.*

	prepgamesdirs
	make_desktop_entry q3demo "Quake III Demo"
}

pkg_postinst() {
	einfo "To play the game run:"
	einfo " q3demo"

	games_pkg_postinst
}
