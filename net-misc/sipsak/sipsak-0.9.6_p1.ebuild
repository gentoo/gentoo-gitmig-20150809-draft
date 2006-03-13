# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sipsak/sipsak-0.9.6_p1.ebuild,v 1.2 2006/03/13 01:33:38 deltacow Exp $

IUSE="gnutls"

DESCRIPTION="small command line tool for testing SIP applications and devices"
HOMEPAGE="http://sipsak.org/"
SRC_URI="http://download.berlios.de/sipsak/${P/_p/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~sparc ~x86"

RDEPEND="gnutls? ( net-libs/gnutls )
		net-dns/c-ares"
#         ares? ( net-dns/c-ares )"

DEPEND="${RDEPEND}
		virtual/libc"
S="${WORKDIR}/${P/_p1/}"

src_compile() {
	econf $(use_enable gnutls) || die 'configure failed'
	emake || die 'make failed'
}

src_install() {
	emake DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
