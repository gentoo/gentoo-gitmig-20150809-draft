# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gphoto/gphoto-0.4.3-r2.ebuild,v 1.13 2004/10/16 19:52:34 liquidx Exp $

inherit eutils flag-o-matic

DESCRIPTION="free, redistributable digital camera software application"
SRC_URI="http://www.gphoto.net/dist/${P}.tar.gz"
HOMEPAGE="http://www.gphoto.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="nls"

DEPEND="media-libs/imlib
	>=media-gfx/imagemagick-4.1"

src_unpack() {
	unpack ${A}
	cd ${S}/sony
	epatch ${FILESDIR}/gphoto-0.4.3-sony-command.c-gentoo.patch
	# gcc 3.2 patch (#53992)
	cd ${S}
	epatch ${FILESDIR}/gphoto-0.4.3-gcc3.patch
}

src_compile() {
	# -pipe does no work
	filter-flags -pipe

	local myconf
	use nls || myconf="${myconf} --disable-nls"

	econf \
		--sysconfdir=/etc/gnome \
		${myconf} || die
	make clean || die

	# This package doesn't always build when parallelized, changed
	# from emake to make (22 Feb 2003 agriffis).
	# See bug #14404
	make || die
}

src_install() {
	 einstall sysconfdir=${D}/etc/gnome || die
	 dodoc AUTHORS CONTACTS COPYING ChangeLog FAQ MANUAL NEWS* PROGRAMMERS \
		 README THANKS THEMES TODO
}
