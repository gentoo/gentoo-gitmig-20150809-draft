# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/msn-pecan/msn-pecan-0.1.1.ebuild,v 1.1 2010/08/28 22:27:59 voyageur Exp $

EAPI="2"

inherit eutils toolchain-funcs multilib

DESCRIPTION="Alternative MSN protocol plugin for libpurple"
HOMEPAGE="http://code.google.com/p/msn-pecan/"

SRC_URI="http://msn-pecan.googlecode.com/files/${P/_/-}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-im/pidgin"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

S=${WORKDIR}/${P/_/-}

src_prepare() {
	sed -e "/^LDFLAGS/{s/$/ ${LDFLAGS}/;}" \
		-e "/^CFLAGS/{s/$/ ${CFLAGS}/;}" -i Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README TODO || die "dodoc failed"
}

pkg_postinst() {
	elog "Select the 'WLM' protocol to use this plugin"
	einfo
	elog "For more information (how to change personal message, add"
	elog "missing emoticons, ...), please read:"
	elog "http://code.google.com/p/msn-pecan/wiki/FAQ"
}
