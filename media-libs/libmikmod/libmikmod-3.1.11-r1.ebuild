# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmikmod/libmikmod-3.1.11-r1.ebuild,v 1.8 2004/11/08 09:12:21 mr_bones_ Exp $

inherit gnuconfig flag-o-matic eutils

DESCRIPTION="A library to play a wide range of module formats"
HOMEPAGE="http://mikmod.raphnet.net/"
SRC_URI="http://mikmod.raphnet.net/files/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 LGPL-2 )"
SLOT="0"
KEYWORDS="x86 amd64 hppa sparc mips alpha ia64 ppc64"
IUSE="oss esd alsa"

DEPEND=">=media-libs/audiofile-0.2.3
	alsa? ( >=media-libs/alsa-lib-0.5.9 )
	esd? ( >=media-sound/esound-0.2.19 )"

src_compile() {
	local myconf

	myconf="--enable-af" # include AudioFile driver
	myconf="${myconf} $(use_enable esd)"
	myconf="${myconf} $(use_enable alsa)"
	myconf="${myconf} $(use_enable oss)"

	# alpha, amd64 and ia64 (at least) need gnuconfig_update
	gnuconfig_update

	# patch for 64bit arch defs for amd64/x86_64
	use amd64 && epatch ${FILESDIR}/${P}-amd64-archdef.patch

	filter-flags -Os

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS NEWS README TODO
	dohtml docs/*.html
}
