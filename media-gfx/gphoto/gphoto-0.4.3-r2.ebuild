# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gphoto/gphoto-0.4.3-r2.ebuild,v 1.12 2004/07/14 17:39:21 agriffis Exp $

inherit flag-o-matic

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
	patch <${FILESDIR}/gphoto-0.4.3-sony-command.c-gentoo.patch
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
