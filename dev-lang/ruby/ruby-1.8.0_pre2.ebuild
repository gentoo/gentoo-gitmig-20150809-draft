# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.8.0_pre2.ebuild,v 1.4 2003/08/01 03:23:26 agriffis Exp $

S=${WORKDIR}/${PN}-`echo ${PV} | sed 's/_pre[0-9]*//'`
DESCRIPTION="An object-oriented scripting language"
SRC_URI="mirror://ruby/${PN}-`echo ${PV} | sed 's/_pre/-preview/'`.tar.gz"
HOMEPAGE="http://www.ruby-lang.org/"
LICENSE="Ruby"
KEYWORDS="~x86"
SLOT="0"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2"

inherit flag-o-matic
filter-flags -fomit-frame-pointer

src_compile() {
	econf
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYING* ChangeLog MANIFEST README* ToDo
}
