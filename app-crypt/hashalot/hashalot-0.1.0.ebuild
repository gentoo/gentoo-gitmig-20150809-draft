# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/hashalot/hashalot-0.1.0.ebuild,v 1.7 2004/02/09 20:40:27 gustavoz Exp $

DESCRIPTION="CryptoAPI utils"
HOMEPAGE="http://www.kerneli.org/"
SRC_URI="http://www.stwing.org/~sluskyb/util-linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc sparc ~hppa ~ia64 ~mips ~arm ~alpha ppc64"

src_install() {
	einstall || die "install error"
}
