# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/djbdns-man/djbdns-man-20031023.ebuild,v 1.13 2007/07/26 18:45:21 armin76 Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Man pages for djbdns"
SRC_URI="http://smarden.org/pape/djb/manpages/djbdns-1.05-man-${PV}.tar.gz"
HOMEPAGE="http://smarden.org/pape/djb/manpages/"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="app-arch/tar app-arch/gzip"
RDEPEND="sys-apps/man"

src_install() {
	dodoc README

	doman *.8 *.5 *.1
}
