# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.8.0_pre2-r1.ebuild,v 1.3 2003/08/05 16:21:25 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI="mirror://ruby/${P/_pre/-preview}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86 ~alpha"
IUSE="socks5 tcltk"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	socks5? ( >=net-misc/dante-1.1.13 )
	tcltk?  ( dev-lang/tk )"

S=${WORKDIR}/${P%_pre*}

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}

	# Allow Ruby to build correctly with Dante/SOCKS support.
	epatch ${FILESDIR}/ruby-1.8.0_pre2-socks.patch
}

src_compile() {
	local myconf=''

	filter-flags -fomit-frame-pointer

	# Socks support via dante
	if use socks5; then
		myconf=--enable-socks
	else
		# Socks support can't be disabled as long as SOCKS_SERVER is
		# set and socks library is present, so need to unset
		# SOCKS_SERVER in that case.
		myconf=--disable-socks
		unset SOCKS_SERVER
	fi

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc COPYING* ChangeLog MANIFEST README* ToDo
}
