# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/daemontools-man/daemontools-man-20020131.ebuild,v 1.15 2004/06/29 14:41:54 kugelfang Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Man pages for daemontools"
SRC_URI="http://smarden.org/pape/djb/manpages/daemontools-0.76-man-20020131.tar.gz"
HOMEPAGE="http://smarden.org/pape/djb/manpages/"

SLOT="0"
LICENSE="public-domain"
IUSE=""
KEYWORDS="x86 ppc sparc amd64"

DEPEND="app-arch/tar app-arch/gzip"
RDEPEND="sys-apps/man"

src_install() {
	dodoc README
	doman *.8
}
