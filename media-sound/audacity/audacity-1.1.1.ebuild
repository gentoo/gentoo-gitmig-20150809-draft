# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacity/audacity-1.1.1.ebuild,v 1.1 2003/01/15 19:02:57 raker Exp $

IUSE="oggvorbis"
DESCRIPTION="A free, crossplatform audio editor."
HOMEPAGE="http://audacity.sourceforge.net/"
LICENSE="GPL-2"
DEPEND=">=x11-libs/wxGTK-2.4.0
	oggvorbis? ( media-libs/libvorbis )
	app-arch/zip
	media-sound/mad
	media-libs/id3lib"
SLOT="0"
KEYWORDS="x86"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.tgz"
S="${WORKDIR}/${PN}-src-${PV}"
inherit eutils

src_unpack() {
	unpack ${PN}-src-${PV}.tgz
	cd ${S}
	epatch ${FILESDIR}/mono_mp3_export.patch || die
}

src_compile() {
	econf || die
	MAKEOPTS=-j1 emake || die
}

src_install () {
	make PREFIX="${D}/usr" install || die
	dodoc LICENSE.txt README.txt
}
