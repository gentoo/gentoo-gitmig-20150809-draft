# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/xhkeys/xhkeys-1.0.0.ebuild,v 1.4 2003/08/06 07:58:30 vapier Exp $

DESCRIPTION="assign particular actions to any key or key combination"
HOMEPAGE="http://www.geocities.com/wmalms/"
SRC_URI="http://www.geocities.com/wmalms/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="x11-base/xfree"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		|| die "./configure failed"
	emake || die
}

src_install() {
	dobin xhkeys xhkconf
	dodoc README VERSION
}
