# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sipsak/sipsak-0.9.5.ebuild,v 1.2 2007/10/21 15:16:41 maekke Exp $

IUSE="gnutls"

DESCRIPTION="small command line tool for testing SIP applications and devices"
HOMEPAGE="http://sipsak.org/"
SRC_URI="http://download.berlios.de/sipsak/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~ppc-macos ~sparc ~x86"

RDEPEND="gnutls? ( net-libs/gnutls )
		net-dns/c-ares"
#         ares? ( net-dns/c-ares )"

DEPEND="${RDEPEND}
		virtual/libc"

src_compile() {
	econf $(use_enable gnutls) || die 'configure failed'
	emake || die 'make failed'
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
