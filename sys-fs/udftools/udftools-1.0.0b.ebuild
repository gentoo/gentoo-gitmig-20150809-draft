# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udftools/udftools-1.0.0b.ebuild,v 1.5 2004/07/01 21:51:39 eradicator Exp $

MY_P="${P}2"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Ben Fennema's tools for packet writing and the UDF filesystem"
SRC_URI="mirror://sourceforge/linux-udf/${MY_P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/linux-udf/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"

DEPEND="virtual/libc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog COPYING
}
