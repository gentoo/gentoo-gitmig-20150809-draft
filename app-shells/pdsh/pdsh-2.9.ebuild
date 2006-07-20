# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/pdsh/pdsh-2.9.ebuild,v 1.1 2006/07/20 05:29:57 dberkholz Exp $

inherit versionator

MY_PV=$(replace_version_separator 2 '-')
MY_P="${PN}-${MY_PV}"
DESCRIPTION="A high-performance, parallel remote shell utility."
HOMEPAGE="http://www.llnl.gov/linux/pdsh/pdsh.html"
SRC_URI="ftp://ftp.llnl.gov/pub/linux/pdsh/${MY_P}.tar.bz2"
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

