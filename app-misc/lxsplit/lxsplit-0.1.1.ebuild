# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/lxsplit/lxsplit-0.1.1.ebuild,v 1.1 2002/08/21 10:46:20 cybersystem Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Command-line file splitter/joiner for Linux."
SRC_URI="http://www.freebyte.com/download/lxsplit.tar.gz"
HOMEPAGE="http://remenic.2y.net/lxsplit/"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	sed "s/^\(CFLAGS[[:space:]]=[[:space:]]\)\(.*\)$/\1${CFLAGS}/" Makefile > Makefile.new
	mv --force Makefile.new Makefile
	emake || die
}

src_install () {
	
	dobin lxsplit	

	# Install documentation.
	dodoc ChangeLog README
}
