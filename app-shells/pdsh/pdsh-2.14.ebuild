# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/pdsh/pdsh-2.14.ebuild,v 1.1 2007/09/08 13:31:40 swegener Exp $

DESCRIPTION="A high-performance, parallel remote shell utility."
HOMEPAGE="http://www.llnl.gov/linux/pdsh/pdsh.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crypt readline rsh"
RDEPEND="crypt? ( net-misc/openssh )
	rsh? ( net-misc/netkit-rsh )
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}"

src_compile() {
	econf \
		--with-machines \
		$(use_with crypt ssh) \
		$(use_with rsh) \
		$(use_with readline) \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
