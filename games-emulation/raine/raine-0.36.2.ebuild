# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/raine/raine-0.36.2.ebuild,v 1.2 2004/02/20 06:26:48 mr_bones_ Exp $

inherit flag-o-matic

DESCRIPTION="R A I N E  M680x0 Arcade Emulation"
HOMEPAGE="http://www.rainemu.com/"
SRC_URI="http://www.rainemu.com/html/archive/raines-${PV}.tar.bz2
	http://www.rainemu.com/html/archive/rainedocs.zip
	http://www.rainemu.com/html/archive/icons.zip"
#	http://www.rainemu.com/html/archive/big-snapshot.zip"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86"
IUSE="static nls"

DEPEND="virtual/glibc
	sys-libs/zlib
	<media-libs/allegro-4.1.0
	media-libs/svgalib"

S=${WORKDIR}/${PN}
RESTRICT=nostrip

src_unpack() {
	unpack ${A}
	cd ${S}

	MARCH_FLAG="`get-flag march`"
	MCPU_FLAG="`get-flag mcpu`"
	[ -z "${MARCH_FLAG}" ] && MARCH_FLAG="${MCPU_FLAG}"
	[ -z "${MCPU_FLAG}" ] && MCPU_FLAG="${MARCH_FLAG}"

	# Force our custom processor instead of pentium
	cp makefile makefile.orig
	sed -e "s:mcpu=pentium:mcpu=${MCPU_FLAG}:" \
		-e "s:march=pentium:march=${MARCH_FLAG}:" \
		-e 's:(prefix)/usr/games:(prefix)/usr/bin:' \
		-e 's:(sharedir)/games/raine:(sharedir)/raine:' \
		makefile.orig > makefile

	# Fix function-name collision with 4.1.x version of allegro
#	patch -p1 < ${FILESDIR}/raine-allegro_4.1.5_fix.patch || die
	cp source/gui/gui.c source/gui/gui.c.orig
	sed -e 's:update_menu(:upd_menu(:' \
		source/gui/gui.c.orig > source/gui/gui.c
}

src_compile() {
	local myopts="OSTYPE=linux RAINE_LINUX=1 VERBOSE=1"

	use static \
		&& myopts="${myopts} STATIC=1" \
		|| myopts="${myopts} STATIC="

	emake ${myopts} || die
}

src_install() {
	make prefix=${D} install || die

	exedat ${D}/usr/bin/raine ${D}/usr/share/raine/raine.dat
	rm -f ${D}/usr/share/raine/raine.dat

	use nls || rm -rf ${D}/usr/share/raine/languages

	dodoc ${WORKDIR}/raine.txt

	insinto /usr/share/icons
	doins ${WORKDIR}/*.png
	if [ `use kde` ] ; then
		insinto /usr/share/applnk/Games
		doins ${FILESDIR}/Raine.desktop
	fi
}
