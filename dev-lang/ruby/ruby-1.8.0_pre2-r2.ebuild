# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.8.0_pre2-r2.ebuild,v 1.2 2003/05/28 14:44:37 scandium Exp $

IUSE="socks5 tcltk"

inherit flag-o-matic eutils

S=${WORKDIR}/${P%_pre*}
DESCRIPTION="An object-oriented scripting language"
SRC_URI="ftp://ftp.ruby-lang.org/pub/ruby/1.8/${P/_pre/-preview}.tar.gz"
HOMEPAGE="http://www.ruby-lang.org/"
LICENSE="Ruby"
KEYWORDS="~x86 ~alpha"
SLOT="0"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	socks5? ( >=net-misc/dante-1.1.13 )
	tcltk?  ( dev-lang/tk )"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}

	# Allow Ruby to build correctly with Dante/SOCKS support.
	epatch ${FILESDIR}/ruby-1.8.0_pre2-socks.patch
}

src_compile() {
	local myconf='--enable-shared'

	filter-flags -fomit-frame-pointer

	# Socks support via dante
	if use socks5; then
		myconf="${myconf} --enable-socks"
	else
		# Socks support can't be disabled as long as SOCKS_SERVER is
		# set and socks library is present, so need to unset
		# SOCKS_SERVER in that case.
		myconf="${myconf} --disable-socks"
		unset SOCKS_SERVER
	fi

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc COPYING* ChangeLog MANIFEST README* ToDo
}
