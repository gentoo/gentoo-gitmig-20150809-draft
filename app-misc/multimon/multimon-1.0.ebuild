# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/multimon/multimon-1.0.ebuild,v 1.6 2002/10/17 00:19:01 vapier Exp $

S=${WORKDIR}/multimon
SRC_URI="http://www.baycom.org/~tom/ham/linux/multimon.tar.gz"
HOMEPAGE="http://www.baycom.org/~tom/ham/linux/multimon.html"
DESCRIPTION="Multimon decodes digital transmission codes using OSS"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11"
RDEPEND="${DEPEND}"

src_compile() {
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	local myarch
	myarch=`uname -m`
	dobin bin-${myarch}/gen bin-${myarch}/mkcostab bin-${myarch}/multimon
}
