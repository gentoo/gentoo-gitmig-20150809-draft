# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fping/fping-2.4_beta2-r1.ebuild,v 1.10 2004/01/15 16:02:33 gmsoft Exp $

S=${WORKDIR}/fping-2.4b2_to
DESCRIPTION="A utility to ping multiple hosts at once"
SRC_URI="http://www.fping.com/download/fping-2.4b2_to.tar.gz"
HOMEPAGE="http://www.fping.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc amd64 hppa"

src_compile() {

	econf || die
	make || die
}

src_install () {

	dosbin fping
	doman fping.8
	dodoc COPYING ChangeLog README
}
