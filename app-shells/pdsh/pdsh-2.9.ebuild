# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/pdsh/pdsh-2.9.ebuild,v 1.3 2008/01/29 01:38:04 jsbronder Exp $

inherit versionator

MY_PV=$(replace_version_separator 2 '-')
MY_P="${PN}-${MY_PV}"
DESCRIPTION="A high-performance, parallel remote shell utility."
HOMEPAGE="https://computing.llnl.gov/linux/pdsh.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="crypt readline"
RDEPEND="crypt? ( net-misc/openssh )
	net-misc/netkit-rsh
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

src_compile() {
	econf \
	    $(use_with crypt ssh) \
		--with-rsh \
	    $(use_with readline) \
	    --with-machines \
	    || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
}
