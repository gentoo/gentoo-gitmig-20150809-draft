# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mtr/mtr-0.49-r1.ebuild,v 1.5 2002/09/04 20:02:03 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Matt's TraceRoute. Excellent network diagnostic tool."
SRC_URI="ftp://ftp.bitwizard.nl/mtr/${P}.tar.gz"
HOMEPAGE="http://www.bitwizard.nl/mtr/"

DEPEND=">=sys-libs/ncurses-5.2
	gtk? ( =x11-libs/gtk+-1.2* )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {
	local myconf
	use gtk || myconf="${myconf} --without-gtk"

	./configure \
		--host=${HOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sbindir=/usr/bin \
		$myconf || die

	make || die
}

src_install() {
	# this binary is universal. ie: it does both console and gtk.

	make prefix=${D}/usr mandir=${D}/usr/share/man sbindir=${D}/usr/bin install || die
	
	dodoc AUTHORS COPYING ChangeLog FORMATS NEWS README SECURITY TODO
}
