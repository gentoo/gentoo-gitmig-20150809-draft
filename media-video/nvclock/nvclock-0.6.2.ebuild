# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvclock/nvclock-0.6.2.ebuild,v 1.1 2003/02/10 21:07:21 vapier Exp $

inherit eutils

MY_P="${PN}${PV}"
S=${WORKDIR}/${MY_P}
SRC_URI="http://www.linuxhardware.org/nvclock/${MY_P}.tar.gz"
DESCRIPTION="NVIDIA overclocking utility"
HOMEPAGE="http://www.linuxhardware.org/nvclock/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="gtk gtk2 qt"

DEPEND="virtual/glibc
	|| (
		gtk2? ( virtual/x11 =x11-libs/gtk+-2* )
		gtk? ( virtual/x11 =x11-libs/gtk+-1* )
	)
	qt? ( virtual/x11 =x11-libs/qt-3* )"
DEPEND="${RDEPEND} sys-devel/autoconf"

src_compile() {
	epatch ${FILESDIR}/${PV}-configure.in.patch
	epatch ${FILESDIR}/${PV}-qt-version-check.patch
	autoconf || die

	export QTDIR=/usr/qt/3
	local myconf="`use_enable qt`"
	[ -z "`use gtk``use gtk2`" ] \
		&& myconf="${myconf} --disable-gtk" \
		|| myconf="${myconf} --enable-gtk"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make prefix=${D}/usr install
	dodoc AUTHORS COPYING README ABOUT ChangeLog FAQ NEWS INSTALL
}
