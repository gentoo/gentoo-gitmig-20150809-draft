# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/minit/minit-0.10.ebuild,v 1.1 2007/01/05 02:30:44 vapier Exp $

inherit eutils

DESCRIPTION="a small yet feature-complete init"
HOMEPAGE="http://www.fefe.de/minit/"
SRC_URI="http://dl.fefe.de/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/libowfat
	dev-libs/dietlibc"

src_compile() {
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" DIET="" || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	mv "${D}"/sbin/shutdown "${D}"/sbin/minit-shutdown || die
	rm "${D}"/sbin/init || die
	dodoc CHANGES README TODO
}
