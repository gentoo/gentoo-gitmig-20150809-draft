# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fmod/fmod-3.73.ebuild,v 1.8 2006/10/02 07:38:14 flameeyes Exp $

IUSE=""

MY_P="fmodapi${PV/.}linux"
S=${WORKDIR}/${MY_P}
DESCRIPTION="music and sound effects library, and a sound processing system"
SRC_URI="http://www.fmod.org/files/${MY_P}.tar.gz"
HOMEPAGE="http://www.fmod.org/"

SLOT="0"
LICENSE="fmod"
KEYWORDS="-* x86"

DEPEND=""
RDEPEND="${DEPEND}
	amd64? ( app-emulation/emul-linux-x86-baselibs )"

RESTRICT="strip"

src_install() {
	dolib api/libfmod-${PV}.so
	dosym /usr/lib/libfmod-${PV}.so /usr/lib/libfmod.so

	insinto /usr/include
	doins api/inc/*

	insinto /usr/share/${PN}/media
	doins media/*
	cp -r samples ${D}/usr/share/${PN}/

	dohtml -r documentation/*
	dodoc README.TXT documentation/Revision.txt
}
