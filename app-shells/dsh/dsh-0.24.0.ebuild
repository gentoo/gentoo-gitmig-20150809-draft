# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/dsh/dsh-0.24.0.ebuild,v 1.7 2008/01/05 00:15:04 jsbronder Exp $

DESCRIPTION="DSH - Distributed Shell"
HOMEPAGE="http://www.netfort.gr.jp/~dancer/software/downloads/"
SRC_URI="http://www.netfort.gr.jp/~dancer/software/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="nls"

DEPEND="dev-libs/libdshconfig"
RDEPEND="${DEPEND}
	virtual/ssh"

src_compile() {
	econf --sysconfdir=/etc/dsh $(use_enable nls) || die
	make || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodir /etc/dsh/group
	dodoc TODO README ChangeLog
}
