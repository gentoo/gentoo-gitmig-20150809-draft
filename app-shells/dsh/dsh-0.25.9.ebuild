# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/dsh/dsh-0.25.9.ebuild,v 1.1 2007/11/23 13:44:16 drac Exp $

DESCRIPTION="Distributed Shell"
HOMEPAGE="http://www.netfort.gr.jp/~dancer/software/downloads/"
SRC_URI="http://www.netfort.gr.jp/~dancer/software/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

DEPEND="dev-libs/libdshconfig"
RDEPEND="${RDEPEND}
	virtual/ssh"

src_compile() {
	econf --sysconfdir=/etc/dsh $(use_enable nls)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodir /etc/dsh/group
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
