# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/camstream/camstream-20070315.ebuild,v 1.9 2008/10/08 10:06:45 flameeyes Exp $

inherit eutils libtool autotools

MY_PV=${PV:2}

DESCRIPTION="Collection of tools for webcams and other video devices"
HOMEPAGE="http://www.smcc.demon.nl/camstream/"
SRC_URI="http://www.smcc.demon.nl/camstream/download/camstream-snapshot-${MY_PV}.tar.gz"
LICENSE="GPL-2"
# amd64, please update the patch
KEYWORDS="amd64 -ppc x86"
SLOT="0"
IUSE="doc mmx"

RDEPEND="=x11-libs/qt-3*
		media-libs/alsa-lib"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack () {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}.patch"
	eautoreconf

	# Camstream has 32 bit asssembler normally.
	# patch has to be adapted
	#use amd64 && epatch ${FILESDIR}/x86_64-asm.patch
	#disabling mmx for amd64 as a workaround
}

src_compile () {
	local myconf
	# Need to fake out Qt or we'll get sandbox problems
	REALHOME="$HOME"
	mkdir -p "$T"/fakehome/.qt
	export HOME="$T/fakehome"
	addwrite "${QTDIR}/etc/settings"
	if ! use mmx || use amd64; then
		myconf="--disable-mmx"
	fi
	econf ${myconf} || die "configure failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install
}
