# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvclock/nvclock-0.6.2-r1.ebuild,v 1.3 2003/10/23 17:07:58 genone Exp $

inherit eutils

MY_P="${PN}${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="NVIDIA Overclocking Utility"
HOMEPAGE="http://www.linuxhardware.org/nvclock/"
SRC_URI="http://www.linuxhardware.org/nvclock/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gtk gtk2 qt"

DEPEND="virtual/glibc
	sys-devel/autoconf
	gtk? (
		!gtk2? ( =x11-libs/gtk+-1.2* )
		gtk2? ( =x11-libs/gtk+-2* )
	)
	qt? ( x11-libs/qt )"

src_compile() {
	epatch ${FILESDIR}/${PV}-configure.in.patch
	use qt && epatch ${FILESDIR}/${PV}-qt-version-check.patch

	autoconf || die

	export QTDIR=/usr/qt/3

	local myconf

	use gtk \
		&& myconf="${myconf} --disable-gtk" \
		|| myconf="${myconf} --enable-gtk"

	use qt && myconf="${myconf} --enable-qt"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make prefix=${D}/usr install
	dodoc AUTHORS COPYING README
}
