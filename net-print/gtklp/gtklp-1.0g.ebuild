# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gtklp/gtklp-1.0g.ebuild,v 1.1 2005/08/02 21:46:24 metalgod Exp $

inherit libtool

DESCRIPTION="A GUI for cupsd"
SRC_URI="mirror://sourceforge/gtklp/${P}.src.tar.gz"
HOMEPAGE="http://gtklp.sourceforge.net"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
LICENSE="GPL-2"
IUSE="gtk2 nls ssl"

DEPEND="!gtk2? ( =x11-libs/gtk+-1.2* )
	gtk2? ( >=x11-libs/gtk+-2 )
	>=net-print/cups-1.1.12
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )"

src_compile() {
	elibtoolize

	local myconf

	# nls fix
	sed -i -e "s:#include <cups/language.h>:#ifndef _LOCALE_H\n#define _LOCALE_H\n#endif\n#include <cups/language.h>:" libgtklp/libgtklp.h

	# package uses gtk2 by default, has switch to request gtk1
	use gtk2 \
		&& myconf="${myconf} --disable-gtk1" \
		|| myconf="${myconf} --enable-gtk1"

	econf \
		${myconf} \
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
