# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvclock/nvclock-0.7-r2.ebuild,v 1.2 2007/07/05 11:40:16 armin76 Exp $

inherit eutils

MY_P="${PN}${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="NVIDIA Overclocking Utility"
HOMEPAGE="http://www.linuxhardware.org/nvclock/"
SRC_URI="http://www.linuxhardware.org/nvclock/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gtk qt3"

RDEPEND="virtual/libc
	gtk? ( =x11-libs/gtk+-2* )
	qt3? ( =x11-libs/qt-3* )"
DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/configure.in.diff
	epatch ${FILESDIR}/callbacks.patch
	epatch ${FILESDIR}/nvclock-insecure-tmp.diff
}

src_compile() {
	mv configure.in configure.ac
	./autogen.sh || die

	# Needed to ensure it compiles against Qt3 rather than Qt4
	export QTDIR=/usr/qt/3
	export MOC=${QTDIR}/bin/moc

	./configure $(use_enable qt3 qt) $(use_enable gtk) || die

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
	elog "To enable card overclocking at startup, edit your /etc/conf.d/nvclock"
	elog "accordingly and then run: rc-update add nvclock default"
}
