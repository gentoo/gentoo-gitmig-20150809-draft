# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpfc/mpfc-1.3.2.ebuild,v 1.1 2004/09/29 21:18:45 pkdawson Exp $

DESCRIPTION="Music Player For Console"
HOMEPAGE="http://mpfc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="alsa oss esd mad oggvorbis gpm"


DEPEND="alsa? ( >=media-libs/alsa-lib-0.9.0 )
	esd? ( >=media-sound/esound-0.2.22 )
	mad? ( media-libs/libmad )
	oggvorbis? ( media-libs/libvorbis )
	gpm? ( >=sys-libs/gpm-1.19.3 )"

src_compile() {
	local myconf=""
	myconf="${myconf} $(use_enable alsa)"
	myconf="${myconf} $(use_enable oss)"
	myconf="${myconf} $(use_enable esd)"
	myconf="${myconf} $(use_enable mad mp3)"
	myconf="${myconf} $(use_enable oggvorbis ogg)"
	myconf="${myconf} $(use_enable gpm)"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	insinto /etc
	doins mpfcrc
}
