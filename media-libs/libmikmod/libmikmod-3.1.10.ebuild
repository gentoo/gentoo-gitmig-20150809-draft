# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmikmod/libmikmod-3.1.10.ebuild,v 1.23 2004/11/08 09:12:21 mr_bones_ Exp $
inherit gnuconfig

IUSE="oss esd alsa"

DESCRIPTION="A library to play a wide range of module formats"
HOMEPAGE="http://mikmod.raphnet.net/"
SRC_URI="http://mikmod.raphnet.net/files/${P/-/_}.tar.gz"

DEPEND=">=media-libs/audiofile-0.2.3
	alsa? ( >=media-libs/alsa-lib-0.5.9 )
	esd? ( >=media-sound/esound-0.2.19 )"

LICENSE="|| ( LGPL-2.1 LGPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"

src_compile() {
	local myconf

	myconf="--enable-af" # include AudioFile driver
	myconf="${myconf} $(use_enable esd)"
	myconf="${myconf} $(use_enable alsa)"
	myconf="${myconf} $(use_enable oss)"

	# needed for alpha and amd64
	gnuconfig_update

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* NEWS README TODO
	dohtml docs/*.html
}
