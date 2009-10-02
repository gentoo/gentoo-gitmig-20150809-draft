# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gtklp/gtklp-1.2.7.ebuild,v 1.1 2009/10/02 06:52:06 pva Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="A GUI for cupsd"
HOMEPAGE="http://gtklp.sourceforge.net"
SRC_URI="mirror://sourceforge/gtklp/${P}.src.tar.gz
	mirror://gentoo/gtklp-logo.png.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="nls ssl"

RDEPEND=">=x11-libs/gtk+-2
	>=net-print/cups-1.1.12
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -e '/DEF_BROWSER_CMD/{s:netscape:firefox:}' \
		-e '/DEF_HELP_HOME/{s:631/sum.html#STANDARD_OPTIONS:631/help/:}' \
		-i include/defaults.h
	eautoreconf # avoid "maintainer mode"
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable ssl)
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog README TODO USAGE || die

	mv gtklp/{logo,gtklp-logo}.xpm
	doicon gtklp/gtklp-logo.xpm
	make_desktop_entry 'gtklp -i' "print files via CUPS" gtklp-logo 'System;Printing'
	make_desktop_entry gtklpq "CUPS queue manager" gtklp-logo 'System;Printing'
}
