# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/nbd/nbd-2.7.3.ebuild,v 1.1 2005/03/29 02:42:34 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Userland client/server for kernel network block device"
HOMEPAGE="http://nbd.sourceforge.net/"
SRC_URI="mirror://sourceforge/nbd/${P}.tar.gz
	mirror://gentoo/nbd-linux-include.h.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	mkdir -p "${S}"/inc-after/linux
	mv "${WORKDIR}"/nbd-linux-include.h "${S}"/inc-after/linux/nbd.h
	append-flags -idirafter "${S}"/inc-after

	sed -i -e "s:-O2:${CFLAGS}:" "${S}"/gznbd/Makefile
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
