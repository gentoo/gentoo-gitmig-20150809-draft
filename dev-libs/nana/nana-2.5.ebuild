# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nana/nana-2.5.ebuild,v 1.2 2004/06/24 23:29:03 agriffis Exp $

inherit gnuconfig

DESCRIPTION="a library that provides support for assertion checking and logging"
SRC_URI="ftp://ftp.cs.ntu.edu.au/pub/nana/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/nana/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-devel/gcc-2.7.2
	>=sys-devel/gdb-4.17"


src_compile() {
	# let nana use up-to-date configure scripts
	gnuconfig_update

	./configure --prefix=/usr --infodir=/usr/share/info \
		--mandir=/usr/share/man --host=${CHOST} || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info install || die "make install failed"

	dodoc ANNOUNCE AUTHORS COPYING ChangeLog NEWS
	dodoc PROJECTS README REGISTRATION THANKS TODO
	dodoc examples/D.ex examples/I.ex examples/Makefile.am
	dodoc examples/Makefile.in examples/install.ex
	dodoc examples/ott.h examples/syslog.c
}
