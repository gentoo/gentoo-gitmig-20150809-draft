# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gtklp/gtklp-1.0g-r1.ebuild,v 1.1 2005/09/20 03:30:29 dang Exp $

inherit libtool

DESCRIPTION="A GUI for cupsd"
SRC_URI="mirror://sourceforge/gtklp/${P}.src.tar.gz"
HOMEPAGE="http://gtklp.sourceforge.net"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
LICENSE="GPL-2"
IUSE="nls ssl"

DEPEND=">=x11-libs/gtk+-2
	>=net-print/cups-1.1.12
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )"

src_compile() {
	elibtoolize

	# nls fix
	sed -i -e "s:#include <cups/language.h>:#ifndef _LOCALE_H\n#define _LOCALE_H\n#endif\n#include <cups/language.h>:" libgtklp/libgtklp.h

	econf \
		$(use_enable nls) \
		$(use_enable ssl) \
		|| die "configure failed"
	emake || die "parallel make failed"
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO || die

	use nls || rm -rf ${D}/usr/share/locale
}
