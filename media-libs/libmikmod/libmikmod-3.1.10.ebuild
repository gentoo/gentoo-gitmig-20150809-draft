# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmikmod/libmikmod-3.1.10.ebuild,v 1.14 2003/04/29 21:35:57 agriffis Exp $
inherit gnuconfig

IUSE="oss esd alsa"

S=${WORKDIR}/${P}
DESCRIPTION="A library to play a wide range of module formats"
SRC_URI="http://www.mikmod.org/files/libmikmod/${P}.tar.gz"
HOMEPAGE="http://www.mikmod.org/"

DEPEND=">=media-libs/audiofile-0.2.3
	alsa? ( >=media-libs/alsa-lib-0.5.9 )
	esd? ( >=media-sound/esound-0.2.19 )"

SLOT="0"
LICENSE="LGPL-2.1 | LGPL-2"
KEYWORDS="x86 ppc sparc alpha"

src_compile() {

	local myconf
	myconf="--enable-af" # include AudioFile driver

	[ -z `use esd` ]  || myconf="${myconf} --enable-esd"
	[ -z `use alsa` ] || myconf="${myconf} --enable-alsa"
	[ -z `use oss` ]  || myconf="${myconf} --enable-oss"

	use alpha && gnuconfig_update

	econf ${myconf} || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* NEWS README TODO
	dohtml docs/*.html
}
