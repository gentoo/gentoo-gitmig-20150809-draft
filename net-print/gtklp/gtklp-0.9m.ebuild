# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gtklp/gtklp-0.9m.ebuild,v 1.8 2004/07/15 03:54:32 agriffis Exp $

inherit libtool

DESCRIPTION="A GUI for cupsd"
SRC_URI="http://www.stud.uni-hannover.de/~sirtobi/gtklp/files/${P}.src.tar.gz"
HOMEPAGE="http://www.stud.uni-hannover.de/~sirtobi/gtklp"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"
IUSE="nls ssl"

DEPEND="=x11-libs/gtk+-1.2*
	>=net-print/cups-1.1.7
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )"

src_compile() {
	elibtoolize

	local myconf

	use nls \
		&& myconf="${myconf} --with-included-gettext" \
		|| myconf="${myconf} --without-included-gettext"

	use ssl \
		&& myconf="${myconf} --enable-ssl" \
		|| myconf="${myconf} --disable-ssl"

	econf ${myconf} || die "configure failed"
	emake || die "parallel make failed"
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO KNOWN_BUGS

	use nls || rm -rf ${D}/usr/share/locale
}
