# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dar/dar-2.0.4-r1.ebuild,v 1.1 2004/02/10 16:58:50 matsuu Exp $

DESCRIPTION="A full featured backup tool, aimed for disks (floppy,CDR(W),DVDR(W),zip,jazz etc.)"
HOMEPAGE="http://dar.linux.free.fr/"
SRC_URI="mirror://sourceforge/dar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="acl"

DEPEND=">=sys-libs/zlib-1.1.3
	>=app-arch/bzip2-1.0.2
	acl? ( sys-apps/attr )"

src_compile() {
	local myconf=""

	use acl && myconf="${myconf} --enable-ea-support"

	econf ${myconf} || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README THANKS TODO
}
