# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptraf/iptraf-3.0.0.ebuild,v 1.1 2005/11/01 05:44:04 vapier Exp $

inherit eutils

DESCRIPTION="IPTraf is an ncurses-based IP LAN monitor"
HOMEPAGE="http://iptraf.seul.org/"
SRC_URI="ftp://iptraf.seul.org/pub/iptraf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2-r1"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch "${FILESDIR}"/${P}-atheros.patch
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-linux-headers.patch
	sed -i \
		-e 's:/var/local/iptraf:/var/lib/iptraf:g' \
		-e "s:Documentation/:/usr/share/doc/${PF}:g" \
		Documentation/*.* || die "sed doc paths"
}

src_compile() {
	emake \
		CFLAGS="${CFLAGS}" \
		LDOPTS="${LDFLAGS}" \
		TARGET="/usr/sbin" \
		WORKDIR="/var/lib/iptraf" \
		-C src || die
}

src_install() {
	dosbin src/{iptraf,rawtime,rvnamed} || die
	dodoc FAQ README* CHANGES RELEASE-NOTES INSTALL
	doman Documentation/*.8
	dohtml -r Documentation/*
	keepdir /var/{lib,run,log}/iptraf
}
