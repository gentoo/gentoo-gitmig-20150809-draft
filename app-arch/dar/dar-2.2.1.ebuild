# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dar/dar-2.2.1.ebuild,v 1.2 2005/03/22 16:00:04 matsuu Exp $

inherit flag-o-matic libtool

DESCRIPTION="A full featured backup tool, aimed for disks (floppy,CDR(W),DVDR(W),zip,jazz etc.)"
HOMEPAGE="http://dar.linux.free.fr/"
SRC_URI="mirror://sourceforge/dar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="acl dar32 dar64 nls static"

DEPEND=">=sys-libs/zlib-1.1.3
	>=app-arch/bzip2-1.0.2
	acl? ( sys-apps/attr )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	# fix build on amd64
	cd ${S}
	einfo "Running autoreconf..."
	autoreconf || die
	einfo "Running libtoolize..."
	elibtoolize
	# Bug 75047.
	libtoolize --copy --force || die
}

src_compile() {
	local myconf="--disable-upx"

	use acl && myconf="${myconf} --enable-ea-support"
	use dar32 && myconf="${myconf} --enable-mode=32"
	use dar64 && myconf="${myconf} --enable-mode=64"
	use nls || myconf="${myconf} --disable-nls"
	use static || myconf="${myconf} --enable-static=no --disable-dar-static"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README THANKS TODO
}
