# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.2.6-r1.ebuild,v 1.14 2006/11/17 23:23:41 compnerd Exp $

inherit eutils

DESCRIPTION="ODBC Interface for Linux"
HOMEPAGE="http://www.unixodbc.org/"
SRC_URI="http://www.unixodbc.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~hppa ~alpha ~amd64 ~sparc"
IUSE="qt3"

DEPEND="virtual/libc
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	qt3? ( =x11-libs/qt-3* )"

# the configure.in patch is required for 'use qt3'
src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	# braindead check in configure fails - hack approach
	epatch ${FILESDIR}/${P}-configure.in.patch

	autoconf || die "autoconf failed"
}

src_compile() {
	local myconf

	if use qt3 ; then
		myconf="--enable-gui=yes --x-libraries=/usr/lib "
	else
		myconf="--enable-gui=no"
	fi

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc/unixODBC \
		${myconf} || die

	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog NEWS README*
	find doc/ -name "Makefile*" -exec rm '{}' \;
	dohtml doc/*
	prepalldocs
}
