# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberoo/jabberoo-1.9.4.ebuild,v 1.2 2004/06/23 00:57:37 humpback Exp $


DESCRIPTION="Jabberoo is a C++ interface to the Jabber protocol."
HOMEPAGE="http://jabberoo.jabberstudio.org/"
SRC_URI="http://www.jabberstudio.org/files/gabber/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="debug"

DEPEND="sys-libs/glibc
	>=dev-libs/libsigc++-1.2"

src_compile() {
	local myconf

	use debug && myconf="${myconf} --enable-debug"

	econf ${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
