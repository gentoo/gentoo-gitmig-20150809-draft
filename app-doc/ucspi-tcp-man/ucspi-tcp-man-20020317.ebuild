# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/ucspi-tcp-man/ucspi-tcp-man-20020317.ebuild,v 1.18 2010/10/19 09:11:31 leio Exp $

DESCRIPTION="Man pages for ucspi-tcp"
HOMEPAGE="http://smarden.org/pape/djb/manpages/"
SRC_URI="http://smarden.org/pape/djb/manpages/ucspi-tcp-0.88-man-20020317.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

S=${WORKDIR}/ucspi-tcp-0.88-man

src_install() {
	dodoc README
	doman *.1 || die "doman failed"
}
