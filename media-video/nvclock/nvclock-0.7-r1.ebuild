# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvclock/nvclock-0.7-r1.ebuild,v 1.2 2003/12/06 18:33:19 spider Exp $

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
	gtk? ( =x11-libs/gtk+-2* )
	qt? ( x11-libs/qt )"

src_compile() {
	epatch ${FILESDIR}/configure.in.diff || die
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

	chmod u+x ${D}/etc/init.d/nvclock

	dodoc AUTHORS COPYING README
}

pkg_postinst() {
	einfo "To enable card overclocking at startup, edit your /etc/conf.d/nvclock"
	einfo "accordingly and then run: rc-update add nvclock default"
}
