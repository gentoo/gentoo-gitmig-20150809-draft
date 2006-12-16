# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ddrescue/ddrescue-1.3.ebuild,v 1.1 2006/12/16 17:27:19 drizzt Exp $

DESCRIPTION="Copies data from one file or block device (hard disk, cdrom, etc) to another, trying hard to rescue data in case of read errors"
HOMEPAGE="http://www.gnu.org/software/ddrescue/ddrescue.html"
SRC_URI="http://savannah.gnu.org/download/ddrescue/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
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
