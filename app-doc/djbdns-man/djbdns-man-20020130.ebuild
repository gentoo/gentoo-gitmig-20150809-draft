# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Thilo Bangert <bangert@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/djbdns-man/djbdns-man-20020130.ebuild,v 1.2 2002/04/27 21:46:44 bangert Exp $

S=${WORKDIR}/${PN}

DESCRIPTION="Man pages for djbdns"
SRC_URI="http://smarden.org/pape/djb/manpages/djbdns-1.05-man-20020130.tar.gz"
HOMEPAGE="http://smarden.org/pape/djb/manpages/"

src_install () {

	dodoc README

	doman *.8 *.5 *.1

}
