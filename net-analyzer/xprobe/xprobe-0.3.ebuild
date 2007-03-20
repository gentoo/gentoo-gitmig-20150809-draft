# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/xprobe/xprobe-0.3.ebuild,v 1.5 2007/03/20 20:37:23 armin76 Exp $

MY_P="${PN}2-${PV}"
DESCRIPTION="Active OS fingerprinting tool - this is Xprobe2"
HOMEPAGE="http://www.sys-security.com/index.php?page=xprobe"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="net-libs/libpcap"

S="${WORKDIR}/${MY_P}"

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS CREDITS CHANGELOG TODO README docs/*
}
