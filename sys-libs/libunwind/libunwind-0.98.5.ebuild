# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libunwind/libunwind-0.98.5.ebuild,v 1.2 2006/04/15 02:18:45 vapier Exp $

DESCRIPTION="portable and efficient API to determine the call-chain of a program"
HOMEPAGE="http://www.hpl.hp.com/research/linux/libunwind/"
SRC_URI="ftp://ftp.hpl.hp.com/pub/linux-ia64/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="7"
KEYWORDS="amd64 ia64 x86"
IUSE=""

DEPEND=""

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
