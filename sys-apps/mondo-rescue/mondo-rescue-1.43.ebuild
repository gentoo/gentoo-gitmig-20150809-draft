# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mondo-rescue/mondo-rescue-1.43.ebuild,v 1.2 2002/07/25 03:28:46 lostlogic Exp $

S=${WORKDIR}/mondo-1.45
DESCRIPTION="a nice backup tool"
SRC_URI="http://www.microwerks.net/~hugo/kp/mondo-1.45.tgz"
HOMEPAGE="http://www.microwerks.net/~hugo/download.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=app-arch/afio-2.4.7
	>=sys-apps/mindi-0.65
	>=sys-apps/bzip2-1.0.1
	>=app-cdr/cdrtools-1.10
	>=sys-libs/ncurses-5.2
	>=sys-libs/slang-1.4.4
	>=dev-libs/lzo-1.07
	>=app-arch/lzop-1.00
	>=dev-libs/newt-0.50
	>=sys-apps/buffer-1.19
	>=sys-apps/syslinux-1.7"

RDEPEND=""

src_compile() {
	./configure 	--host=${CHOST} \
			--prefix=/usr || die "configure failed"
	emake || die "make failed"
}

src_install () {
	make prefix=${D}/usr install || die "make install failed"
}
