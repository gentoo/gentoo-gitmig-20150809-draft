# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/daemontools-man/daemontools-man-20020131.ebuild,v 1.12 2004/03/14 00:14:29 mr_bones_ Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Man pages for daemontools"
SRC_URI="http://smarden.org/pape/djb/manpages/daemontools-0.76-man-20020131.tar.gz"
HOMEPAGE="http://smarden.org/pape/djb/manpages/"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86 ppc sparc"

DEPEND="app-arch/tar app-arch/gzip"
RDEPEND="sys-apps/man"

src_install() {
	dodoc README
	doman *.8
}
