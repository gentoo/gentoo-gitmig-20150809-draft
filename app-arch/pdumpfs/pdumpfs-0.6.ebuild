# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pdumpfs/pdumpfs-0.6.ebuild,v 1.1 2003/09/09 01:03:25 matsuu Exp $

DESCRIPTION="a daily backup system similar to Plan9's dumpfs"
HOMEPAGE="http://www.namazu.org/~satoru/pdumpfs/"
SRC_URI="http://www.namazu.org/~satoru/pdumpfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="cjk"

DEPEND="virtual/glibc"
RDEPEND="dev-lang/ruby"

S=${WORKDIR}/${P}

src_install() {
	dobin pdumpfs
	dosed 's:/usr/local:/usr:g' /usr/bin/pdumpfs

	doman man/man8/pdumpfs.8

	if [ "`use cjk`" ]; then
		iconv -f iso-2022-jp -t euc-jp man/ja/man8/pdumpfs.8 > ${T}/pdumpfs.8
		insinto /usr/share/man/ja/man8
		doins ${T}/pdumpfs.8
	fi

	dodoc ChangeLog
	dohtml *.html
}
