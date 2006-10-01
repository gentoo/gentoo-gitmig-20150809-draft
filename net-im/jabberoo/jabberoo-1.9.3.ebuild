# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberoo/jabberoo-1.9.3.ebuild,v 1.6 2006/10/01 19:38:02 tester Exp $


DESCRIPTION="Jabberoo is a C++ interface to the Jabber protocol."
HOMEPAGE="http://jabberoo.jabberstudio.org/"
SRC_URI="http://www.jabberstudio.org/files/gabber/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc"

IUSE="debug"

DEPEND="sys-libs/glibc
	=dev-libs/libsigc++-1.2*"

src_compile() {
	local myconf

	use debug && myconf="${myconf} --enable-debug"

	econf ${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
