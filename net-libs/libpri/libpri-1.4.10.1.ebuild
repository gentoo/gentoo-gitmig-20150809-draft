# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpri/libpri-1.4.10.1.ebuild,v 1.1 2009/07/27 19:59:30 volkmar Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Primary Rate ISDN (PRI) library"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://downloads.digium.com/pub/${PN}/releases/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.4.9-respect-cflags.patch"
	epatch "${FILESDIR}/${PN}-1.4.9-multilib.patch"

	# remove -Werror, fix bug 260923
	sed -i -e "s/-Werror //" Makefile || die "sed failed"
}

src_install() {
	emake INSTALL_PREFIX="${D}" LIBDIR="${D}/usr/$(get_libdir)" install \
		|| die "emake install failed"

	dodoc ChangeLog README TODO || die "dodoc failed"
}
