# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/noexec/noexec-1.1.0.ebuild,v 1.4 2004/11/06 16:21:33 pyrania Exp $

DESCRIPTION="a package for preventing processes from using exec system calls"
HOMEPAGE="http://noexec.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=sys-libs/glibc-2.3.2-r9"

src_install() {
	make install DESTDIR=${D} || die "installation failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README
}
