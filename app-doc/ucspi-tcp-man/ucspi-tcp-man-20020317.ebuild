# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/ucspi-tcp-man/ucspi-tcp-man-20020317.ebuild,v 1.4 2002/08/01 14:02:44 seemant Exp $

S=${WORKDIR}/ucspi-tcp-0.88-man

DESCRIPTION="Man pages for ucspi-tcp"
SRC_URI="http://smarden.org/pape/djb/manpages/ucspi-tcp-0.88-man-20020317.tar.gz"
HOMEPAGE="http://smarden.org/pape/djb/manpages/"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86 ppc sparc sparc64"

src_install () {
	dodoc README
	doman *.1
}
