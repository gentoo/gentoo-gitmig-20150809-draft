# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpri/libpri-1.4.11.3.ebuild,v 1.1 2010/07/13 14:01:39 chainsaw Exp $

EAPI="3"

EAPI=3
inherit base

DESCRIPTION="Primary Rate ISDN (PRI) library"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://downloads.asterisk.org/pub/telephony/${PN}/releases/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc"
IUSE=""

PATCHES=(
	"${FILESDIR}/${PN}-1.4.11.1-multilib.patch"
	"${FILESDIR}/${PN}-1.4.11.1-respect-cflags.patch"
	"${FILESDIR}/${PN}-1.4.11.1-respect-ldflags.patch"
	"${FILESDIR}/${PN}-1.4.11.1-werror-is-ill-advised.patch"
)

src_install() {
	emake INSTALL_PREFIX="${D}" LIBDIR="${D}/usr/$(get_libdir)" install \
		|| die "emake install failed"

	dodoc ChangeLog README TODO || die "dodoc failed"
}
