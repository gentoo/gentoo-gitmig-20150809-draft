# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvclock/nvclock-0.6.2-r1.ebuild,v 1.2 2003/08/07 04:14:55 vapier Exp $

inherit eutils

MY_P="${PN}${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="NVIDIA Overclocking Utility"
HOMEPAGE="http://www.linuxhardware.org/nvclock/"
SRC_URI="http://www.linuxhardware.org/nvclock/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gtk qt"

DEPEND="virtual/glibc
	sys-devel/autoconf
	gtk? ( =x11-libs/gtk+-1.2* )
	gtk2? ( =x11-libs/gtk+-2* )
	qt? ( x11-libs/qt )"

src_compile() {
	epatch ${FILESDIR}/${PV}-configure.in.patch
	use qt && epatch ${FILESDIR}/${PV}-qt-version-check.patch

	autoconf || die

	export QTDIR=/usr/qt/3

	local myconf

	[ -z "`use gtk``use gtk2`" ] \
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
