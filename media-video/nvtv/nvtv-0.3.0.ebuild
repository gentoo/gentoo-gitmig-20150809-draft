# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Bart Lauwers <blauwers@cisco.com>
# $Header: /var/cvsroot/gentoo-x86/media-video/nvtv/nvtv-0.3.0.ebuild,v 1.1 2002/05/03 01:42:22 agenkin Exp $

DESCRIPTION="TV-Out for NVidia cards."
HOMEPAGE="http://sourceforge.net/projects/nv-tv-out"
LICENSE="GPL-2"

SRC_URI="http://unc.dl.sourceforge.net/sourceforge/nv-tv-out/${P}.tar.gz"

DEPEND="sys-apps/pciutils"

S=${WORKDIR}/${PN}

src_compile() {
	local myconf
	cd src

	use gtk && myconf="${myconf} --with-gtk" || myconf="${myconf} --without-gtk"
	use X && myconf="${myconf} --with-x" || myconf="${myconf} --without-x"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"

	# The CFLAGS don't seem to make it into the Makefile.
	emake CXFLAGS="${CFLAGS}" || die
}

src_install () {
	dobin src/nvtv
	dosbin src/nvtvd

	dodoc ANNOUNCE BUGS FAQ INSTALL README \
		doc/USAGE doc/XFREE doc/chips.txt \
		doc/overview.txt  doc/timing.txt xine/tvxine

	exeinto /etc/init.d
	newexe ${FILESDIR}/nvtv.start nvtv
}
