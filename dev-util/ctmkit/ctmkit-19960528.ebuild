# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ctmkit/ctmkit-19960528.ebuild,v 1.10 2004/07/14 22:55:22 agriffis Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="old NetBSD port of FreeBSD's CTM, a set of utilities to synchronize directories through email"
HOMEPAGE="http://www.nemeton.com.au/"
SRC_URI="http://www.nemeton.com.au/src/${PN}.tar.gz"

SLOT="0"
LICENSE="public-domain RSA-MD2 RSA-MD4 RSA-MD5 as-is"
KEYWORDS="x86 s390"
IUSE=""

DEPEND="virtual/libc"

src_compile() {

	cp ${FILESDIR}/Makefile .
	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc ctm/README
	doman md5/md5.1 libmd/mdX.3 ctm/ctm/ctm.1 ctm/ctm/ctm.5 ctm/ctm_rmail/ctm_rmail.1
}
