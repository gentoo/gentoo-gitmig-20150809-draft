# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/ctmkit/ctmkit-19960528.ebuild,v 1.1 2002/09/08 21:52:34 blocke Exp $

MY_P="ctmkit"
S=${WORKDIR}/ctmkit
DESCRIPTION="old NetBSD port of FreeBSD's CTM, a set of utilities to synchronize directories through email"
HOMEPAGE="http://www.nemeton.com.au/"
SRC_URI="http://www.nemeton.com.au/src/${MY_P}.tar.gz"
KEYWORDS="x86"
SLOT="0"
LICENSE="public-domain RSA-MD2 RSA-MD3 RSA-MD5 as-is"

DEPEND="virtual/glibc"

src_compile() {

	cp ${FILESDIR}/Makefile .
	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc ctm/README 
	doman md5/md5.1 libmd/mdX.3 ctm/ctm/ctm.1 ctm/ctm/ctm.5 ctm/ctm_rmail/ctm_rmail.1
}

