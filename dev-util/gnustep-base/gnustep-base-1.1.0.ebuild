# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Nick Hadaway <raker@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnustep-base/gnustep-base-1.1.0.ebuild,v 1.1 2002/07/05 01:28:46 raker Exp $

DESCRIPTION="GNUstep base package"
HOMEPAGE="http://www.gnustep.org"
LICENSE="LGPL"
DEPEND=">=dev-util/gnustep-make-1.2.1"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"

src_compile() {
	./configure \
		--host=${CHOST} || die "./configure failed"
	emake || die
}

src_install () {
}
