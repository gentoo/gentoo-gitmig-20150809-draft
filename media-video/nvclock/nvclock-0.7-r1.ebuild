# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvclock/nvclock-0.7-r1.ebuild,v 1.5 2004/10/06 09:17:27 phosphan Exp $

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

DEPEND="virtual/libc
	sys-devel/autoconf
	gtk? ( =x11-libs/gtk+-2* )
	qt? ( =x11-libs/qt-3* )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/configure.in.diff
	epatch ${FILESDIR}/callbacks.patch
}

src_compile() {
	mv configure.in configure.ac
	./autogen.sh || die

	export QTDIR=/usr/qt/3

	local myconf

	use gtk || myconf="${myconf} --disable-gtk"
	use qt && myconf="${myconf} --enable-qt"

	./configure ${myconf} || die
	make || die
}

src_install() {
	dodir /usr/bin /etc/init.d /etc/conf.d
	einstall || die

	cp ${FILESDIR}/nvclock_initd ${D}/etc/init.d/nvclock
	cp ${FILESDIR}/nvclock_confd ${D}/etc/conf.d/nvclock

	chmod a+x ${D}/etc/init.d/nvclock

	dodoc AUTHORS COPYING README
}

pkg_postinst() {
	einfo "To enable card overclocking at startup, edit your /etc/conf.d/nvclock"
	einfo "accordingly and then run: rc-update add nvclock default"
}
