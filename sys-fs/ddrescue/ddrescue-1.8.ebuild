# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ddrescue/ddrescue-1.8.ebuild,v 1.3 2009/01/11 19:14:50 maekke Exp $

inherit toolchain-funcs

DESCRIPTION="Copies data from one file or block device (hard disk, cdrom, etc) to another, trying hard to rescue data in case of read errors"
HOMEPAGE="http://www.gnu.org/software/ddrescue/ddrescue.html"
SRC_URI="http://savannah.gnu.org/download/ddrescue/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND=""

src_compile() {
	# not a normal configure script
	./configure \
		--prefix=/usr \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		CPPFLAGS="${CPPFLAGS}" \
		CFLAGS="${CFLAGS}" \
		CXXFLAGS="${CXXFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install install-man || die "make install failed"
	dodoc ChangeLog INSTALL README NEWS AUTHORS TODO
}
