# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wavemon/wavemon-0.4.0b-r2.ebuild,v 1.6 2009/06/02 13:35:50 flameeyes Exp $

inherit toolchain-funcs flag-o-matic eutils linux-info

DESCRIPTION="Ncurses based monitor for IEEE 802.11 wireless LAN cards"
HOMEPAGE="http://www.janmorgenstern.de/projects-software.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ~sparc x86"

IUSE=""
DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/wavemon-gcc-fixes.patch
	epatch "${FILESDIR}"/${P}-includes.patch
	epatch "${FILESDIR}"/${P}-asneeded.patch

	append-flags "-I${KV_DIR}/include"

	sed -i \
		-e "s|^CFLAGS=\".*\"|CFLAGS=\"${CFLAGS}\"|" \
		"${S}"/configure
}

src_compile() {
	CC=$(tc-getCC) econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir /usr/bin /usr/share/man/{man1,man5}

	make prefix="${D}"/usr mandir="${D}"/usr/share/man install \
		|| die "make install failed"

	dodoc AUTHORS Changelog README TODO
}
