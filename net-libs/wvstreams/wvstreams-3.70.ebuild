# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/wvstreams/wvstreams-3.70.ebuild,v 1.1 2002/04/27 13:18:22 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A network programming library in C++"
SRC_URI="http://open.nit.ca/download/${P}.tar.gz"
HOMEPAGE="http://open.nit.ca/wvstreams"

DEPEND="virtual/glibc"

src_install() {

	make \
		PREFIX=${D}/usr \
		install || dir
}
