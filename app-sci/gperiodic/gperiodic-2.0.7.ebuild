# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gperiodic/gperiodic-2.0.7.ebuild,v 1.1 2004/11/17 16:04:34 ribosome Exp $

inherit toolchain-funcs

DESCRIPTION="Periodic table application for Linux"
SRC_URI="http://www.acclab.helsinki.fi/~frantz/software/${P}.tar.gz"
HOMEPAGE="http://www.acclab.helsinki.fi/~frantz/software/gperiodic.php"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls"

DEPEND=">=sys-libs/ncurses-5.2
	=x11-libs/gtk+-2*
	>=dev-util/pkgconfig-0.12
	nls? ( sys-devel/gettext )"

src_compile() {
	# The author has removed "unnecessary automake/autoconf setup"
#	econf `use_enable nls` || die
	# This flag stopped it compiling for me
	sed -i -e "s/-DGTK_DISABLE_DEPRECATED/${CFLAGS}/" Makefile
	sed -i -e "/make clean/d" Makefile
	sed -i -e "s/CC=gcc/CC=$(tc-getCC)/" Makefile
	if ! use nls; then
		sed -i -e "/make -C po/d" Makefile
	fi
	emake || die "emake failed!"
}

src_install() {
	sed -i -e "s|/usr/bin|${D}/usr/bin|" Makefile
	sed -i -e "s|/usr/share|${D}/usr/share|" Makefile
	sed -i -e "s|/usr/share|${D}/usr/share|" po/Makefile

	# Create directories - Makefile is quite broken.
	dodir /usr/bin
	dodir /usr/share/pixmaps
	dodir /usr/share/applications

	make install || die "make install failed."

	# Fix permissions
	chmod 644 ${D}/usr/share/pixmaps/*
	chmod 644 ${D}/usr/share/applications/*

	# The man page seems to have been removed too.
#	doman man/gperiodic.1
	dodoc AUTHORS ChangeLog README NEWS
	newdoc po/README README.translation
}
