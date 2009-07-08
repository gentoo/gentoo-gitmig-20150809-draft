# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ddrescue/ddrescue-1.9.ebuild,v 1.4 2009/07/08 22:05:00 fauli Exp $

inherit toolchain-funcs

DESCRIPTION="Copies data from one file or block device to another with read-error recovery"
HOMEPAGE="http://www.gnu.org/software/ddrescue/ddrescue.html"
SRC_URI="http://savannah.gnu.org/download/ddrescue/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

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
