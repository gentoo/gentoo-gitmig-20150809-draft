# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.8.0.ebuild,v 1.2 2003/08/11 01:34:51 agriffis Exp $

inherit flag-o-matic eutils gnuconfig

S=${WORKDIR}/${P%_pre*}
DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI="mirror://ruby/${PV%.*}/${P/_pre/-preview}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86 ~alpha"
IUSE="socks5 tcltk"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	socks5? ( >=net-misc/dante-1.1.13 )
	tcltk?  ( dev-lang/tk )
	sys-apps/findutils"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}

	# Enable build on alpha EV67
	if use alpha; then
		gnuconfig_update || die "gnuconfig_update failed"
	fi
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

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc COPYING* ChangeLog MANIFEST README* ToDo
	# Fix perms on directories (bug # 22446)
	find ${D} -type d -print0 | xargs -0 chmod 755
}

pkg_postinst() {
	ewarn
	ewarn "Warning: Vim won't work if you've just updated ruby from"
	ewarn "1.6.8 to 1.8.0 due to the library version change."
	ewarn "In that case, you will need to remerge vim."
	ewarn
}
