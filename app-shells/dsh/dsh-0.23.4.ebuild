# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/dsh/dsh-0.23.4.ebuild,v 1.4 2003/07/02 12:47:28 aliz Exp $

DESCRIPTION="DSH - Distributed Shell"
SRC_URI="http://www.netfort.gr.jp/~dancer/software/downloads/${P}.tar.gz"
HOMEPAGE="http://www.netfort.gr.jp/~dancer/software/downloads/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

DEPEND="dev-libs/libdshconfig"
RDEPEND="net-misc/openssh"

src_compile() {
	econf --with-gnu-ld `use_enable nls` || die

	make || die
}

src_install() {
	make install DESTDIR=${D} || die
}
