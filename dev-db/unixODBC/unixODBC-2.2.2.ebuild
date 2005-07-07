# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.2.2.ebuild,v 1.21 2005/07/07 04:31:57 caleb Exp $

inherit eutils

DESCRIPTION="ODBC Interface for Linux"
HOMEPAGE="http://www.unixodbc.org/"
SRC_URI="http://www.unixodbc.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~hppa ~alpha amd64"
IUSE="qt"

DEPEND="virtual/libc
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	qt? ( =x11-libs/qt-3* )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Original Makefile.in is trying to create and install files directly in /etc so we
	# need to edit the file to make it DESTDIR sensitive.
	cp Makefile.in Makefile.orig
	sed -e "s:touch :touch \${DESTDIR}/:" -e "s:mkdir -p :mkdir -p \${DESTDIR}/:" Makefile.orig > Makefile.in
	epatch ${FILESDIR}/gentoo-yac.diff
}

src_compile() {
	local myconf
	if use qt ; then
		myconf="--enable-gui=yes"
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
