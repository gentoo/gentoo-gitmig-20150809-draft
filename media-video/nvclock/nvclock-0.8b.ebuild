# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvclock/nvclock-0.8b.ebuild,v 1.1 2005/08/30 22:53:45 malverian Exp $

inherit eutils

MY_P="${PN}${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="NVIDIA Overclocking Utility"
HOMEPAGE="http://www.linuxhardware.org/nvclock/"
SRC_URI="http://www.linuxhardware.org/nvclock/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gtk qt"

RDEPEND="virtual/libc
	gtk? ( =x11-libs/gtk+-2* )
	qt? ( =x11-libs/qt-3* )"
DEPEND="${RDEPEND}
	sys-devel/autoconf"

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
	dodir /usr/bin
	einstall || die
	dodoc AUTHORS README

	newinitd ${FILESDIR}/nvclock_initd nvclock
	newconfd ${FILESDIR}/nvclock_confd nvclock
}

pkg_postinst() {
	einfo "To enable card overclocking at startup, edit your /etc/conf.d/nvclock"
	einfo "accordingly and then run: rc-update add nvclock default"
}
