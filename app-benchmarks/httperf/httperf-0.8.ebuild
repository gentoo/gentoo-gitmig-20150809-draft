# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/httperf/httperf-0.8.ebuild,v 1.1 2005/08/17 20:51:18 ka0ttic Exp $

inherit eutils

DESCRIPTION="A tool from HP for measuring web server performance."
HOMEPAGE="http://www.hpl.hp.com/research/linux/httperf/index.php"
SRC_URI="ftp://ftp.hpl.hp.com/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~mips ~sparc ~x86"
IUSE="debug ssl"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-optional-ssl.diff
	epatch ${FILESDIR}/${P}-respect-DESTDIR.diff
}

src_compile() {
	einfo "Regenerating configure"
	autoconf || die "autoconf failed"

	econf --bindir=/usr/bin \
		$(use_enable debug) \
		$(use_enable ssl) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
