# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/djbdns-man/djbdns-man-20020130.ebuild,v 1.12 2004/03/14 00:14:29 mr_bones_ Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Man pages for djbdns"
SRC_URI="http://smarden.org/pape/djb/manpages/djbdns-1.05-man-20020130.tar.gz"
HOMEPAGE="http://smarden.org/pape/djb/manpages/"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86 ppc sparc"

DEPEND="app-arch/tar app-arch/gzip"
RDEPEND="sys-apps/man"

src_install() {
	dodoc README

	doman *.8 *.5 *.1
}
