# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gtklp/gtklp-1.2.2.ebuild,v 1.1 2006/06/05 22:19:49 genstef Exp $

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
	econf \
		$(use_enable nls) \
		$(use_enable ssl) \
		|| die "configure failed"
	emake || die "parallel make failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README README.FAQ TODO USAGE

	use nls || rm -rf "${D}"/usr/share/locale
}
