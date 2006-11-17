# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.2.8.ebuild,v 1.23 2006/11/17 23:23:41 compnerd Exp $

inherit eutils gnuconfig multilib

DESCRIPTION="ODBC Interface for Linux"
HOMEPAGE="http://www.unixodbc.org/"
SRC_URI="http://www.unixodbc.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc mips ~alpha arm hppa ~amd64 s390 ppc64"
IUSE="qt3"

DEPEND="virtual/libc
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	!mips? ( qt3? ( =x11-libs/qt-3* ) )"

# the configure.in patch is required for 'use qt3'
src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	# braindead check in configure fails - hack approach
	epatch ${FILESDIR}/unixODBC-2.2.6-configure.in.patch

	libtoolize --copy --force || die "libtoolize failed"
	autoconf || die "autoconf failed"
}

src_compile() {
	local myconf

	if use qt3 && ! use mips
	then
		myconf="--enable-gui=yes --x-libraries=/usr/$(get_libdir) "
	else
		myconf="--enable-gui=no"
	fi

	# Fix multilib-strict BUG #94262
	myconf="${myconf} --libdir=\${exec_prefix}/$(get_libdir)"

	# Detect mips systems properly
	gnuconfig_update

	./configure --host=${CHOST} \
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
