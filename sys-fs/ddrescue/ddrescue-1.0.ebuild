# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ddrescue/ddrescue-1.0.ebuild,v 1.1 2005/06/26 07:26:18 vapier Exp $

DESCRIPTION="Copies data from one file or block device (hard disk, cdrom, etc) to another, trying hard to rescue data in case of read errors"
HOMEPAGE="http://www.gnu.org/software/ddrescue/ddrescue.html"
SRC_URI="http://savannah.gnu.org/download/ddrescue/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '/^CXXFLAGS/d' Makefile.in
}

src_compile() {
	# not a normal configure script
	./configure --prefix=/usr || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install install-man || die "make install failed"
	dodoc ChangeLog INSTALL README NEWS AUTHORS TODO
}
