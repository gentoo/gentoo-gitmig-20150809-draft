# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dar/dar-2.1.6.ebuild,v 1.4 2005/03/22 16:00:04 matsuu Exp $

inherit flag-o-matic libtool

DESCRIPTION="A full featured backup tool, aimed for disks (floppy,CDR(W),DVDR(W),zip,jazz etc.)"
HOMEPAGE="http://dar.linux.free.fr/"
SRC_URI="mirror://sourceforge/dar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="acl"

DEPEND=">=sys-libs/zlib-1.1.3
	>=app-arch/bzip2-1.0.2
	acl? ( sys-apps/attr )"

src_unpack() {
	unpack ${A}
	# fix build on amd64
	cd ${S}
	einfo "Running autoreconf..."
	autoreconf
	einfo "Running libtoolize..."
	elibtoolize
	# Bug 75047.
	libtoolize --copy --force || die
}

src_compile() {
	local myconf="--disable-upx"

	use acl && myconf="${myconf} --enable-ea-support"

	# Replace -O[3-9] flags; because dar-2.1.0 could not compile.
	replace-flags -O[3-9] -O2
	filter-flags "-fno-default-inline"

	econf ${myconf} || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README THANKS TODO
}
