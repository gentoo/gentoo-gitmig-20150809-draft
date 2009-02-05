# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/pdsh/pdsh-2.17.ebuild,v 1.1 2009/02/05 00:24:58 jsbronder Exp $

inherit eutils

DESCRIPTION="A high-performance, parallel remote shell utility."
HOMEPAGE="https://computing.llnl.gov/linux/pdsh.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crypt readline rsh"
RDEPEND="crypt? ( net-misc/openssh )
	rsh? ( net-misc/netkit-rsh )
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}"

# Feel free to debug the test suite.
RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-2.14-gcc-4.3-unistd.h.patch
	epatch "${FILESDIR}"/${PN}-2.14-glibc-2.8-ARG_MAX.patch
}

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
