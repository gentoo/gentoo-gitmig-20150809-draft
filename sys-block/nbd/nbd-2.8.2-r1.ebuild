# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/nbd/nbd-2.8.2-r1.ebuild,v 1.2 2005/12/22 18:53:28 blubb Exp $

inherit eutils flag-o-matic

DESCRIPTION="Userland client/server for kernel network block device"
HOMEPAGE="http://nbd.sourceforge.net/"
SRC_URI="mirror://sourceforge/nbd/${P}.tar.gz
	mirror://gentoo/nbd-linux-include.h.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gznbd.patch
	epatch "${FILESDIR}"/${P}-buffer-check.patch

	mkdir -p "${S}"/inc-after/linux
	mv "${WORKDIR}"/nbd-linux-include.h "${S}"/inc-after/linux/nbd.h
	append-flags -idirafter "${S}"/inc-after
}

src_compile() {
	econf \
		--enable-lfs \
		--enable-syslog \
		|| die
	emake || die
	emake -C gznbd || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dobin gznbd/gznbd || die
	dodoc README
}
