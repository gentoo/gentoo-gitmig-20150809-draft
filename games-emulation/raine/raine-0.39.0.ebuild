# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/raine/raine-0.39.0.ebuild,v 1.1 2004/01/14 02:41:41 vapier Exp $

inherit games

DESCRIPTION="R A I N E  M680x0 Arcade Emulation"
HOMEPAGE="http://www.rainemu.com/"
SRC_URI="http://www.rainemu.com/html/archive/raines-${PV}.tar.bz2
	http://www.rainemu.com/html/archive/rainedocs.zip
	http://www.rainemu.com/html/archive/icons.zip"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86"
IUSE="static debug nls"

DEPEND="virtual/glibc
	sys-libs/zlib
	media-libs/svgalib"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	echo > detect-cpu
	echo > cpuinfo
}

src_compile() {
	local myopts=
	use static \
		&& myopts="${myopts} STATIC=1" \
		|| myopts="${myopts} STATIC="
	use debug \
		&& myopts="${myopts} RAINE_DEBUG=1" \
		|| myopts="${myopts} RAINE_DEBUG="
	emake \
		_MARCH="${CFLAGS}" \
		OSTYPE=linux \
		RAINE_LINUX=1 \
		${myopts} || die
}

src_install() {
	make prefix=${D} install || die
	dogamesbin ${D}/usr/games/raine
	rm ${D}/usr/games/raine

	use nls || rm -rf ${D}/usr/share/raine/languages

	dodoc ${WORKDIR}/raine.txt

	insinto /usr/share/icons
	doins ${WORKDIR}/*.png
	if [ `use kde` ] ; then
		insinto /usr/share/applnk/Games
		doins ${FILESDIR}/Raine.desktop
	fi

	prepgamesdirs
}
