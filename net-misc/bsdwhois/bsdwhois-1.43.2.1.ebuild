# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bsdwhois/bsdwhois-1.43.2.1.ebuild,v 1.8 2006/11/02 16:38:03 drizzt Exp $

DESCRIPTION="FreeBSD Whois Client"
HOMEPAGE="http://www.freebsd.org/"
SRC_URI="http://utenti.gufi.org/~drizzt/codes/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die

	if [[ "$USERLAND" != "BSD" ]]; then
		mv "${D}"/usr/share/man/man1/{whois,bsdwhois}.1
		mv "${D}"/usr/bin/{whois,bsdwhois}
	fi
}
