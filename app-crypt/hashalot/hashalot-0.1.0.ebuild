# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/hashalot/hashalot-0.1.0.ebuild,v 1.1 2003/12/03 00:13:46 brad_mssw Exp $

DESCRIPTION="CryptoAPI utils"
HOMEPAGE="http://www.kerneli.org/"
SRC_URI="http://www.stwing.org/~sluskyb/util-linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"

#src_compile() {
#	local myconf
#	use nls || myconf="--disable-nls"
#	econf ${myconf} || die "configure error"
#	emake || die "make error"
#}

#src_install() {
#	einstall || die "install error"
#	dodoc README NEWS AUTHORS COPYING THANKS TODO
#}
