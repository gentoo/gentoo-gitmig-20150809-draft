# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvclock/nvclock-0.7.ebuild,v 1.2 2003/11/05 15:18:25 malverian Exp $

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
	gtk? ( =x11-libs/gtk+-2* )
	qt? ( x11-libs/qt )"

src_compile() {
	epatch ${FILESDIR}/configure.in.diff || die
	./autogen.sh || die

	export QTDIR=/usr/qt/3

	local myconf

	use gtk || myconf="${myconf} --disable-gtk"
	use qt && myconf="${myconf} --enable-qt"

	./configure ${myconf} || die
	make || die
}

src_install() {
	dodir /usr/bin
	einstall || die
	dodoc AUTHORS COPYING README
}
