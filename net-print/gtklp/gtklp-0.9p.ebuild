# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gtklp/gtklp-0.9p.ebuild,v 1.8 2005/01/05 16:12:45 sekretarz Exp $

inherit libtool

DESCRIPTION="A GUI for cupsd"
SRC_URI="mirror://sourceforge/gtklp/${P}.src.tar.gz"
HOMEPAGE="http://gtklp.sourceforge.net"

SLOT="0"
KEYWORDS="x86 ppc ~sparc ~amd64"
LICENSE="GPL-2"
IUSE="nls ssl"

DEPEND="=x11-libs/gtk+-1.2*
	>=net-print/cups-1.1.7
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )"

src_compile() {
	elibtoolize

	local myconf

	# nls fix
	sed -i -e "s:#include <cups/language.h>:#ifndef _LOCALE_H\n#define _LOCALE_H\n#endif\n#include <cups/language.h>:" libgtklp/libgtklp.h

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

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
