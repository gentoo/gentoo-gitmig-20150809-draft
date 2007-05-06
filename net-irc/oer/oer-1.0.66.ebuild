# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/oer/oer-1.0.66.ebuild,v 1.3 2007/05/06 12:38:16 genone Exp $

inherit fixheadtails eutils versionator

DESCRIPTION="Free to use GPL'd IRC bot"
HOMEPAGE="http://oer.equnet.org/"
SRC_URI="http://oer.equnet.org/testing/${PN}-$(replace_version_separator 2 -).tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}-dist

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/1.0.64-basename.patch

	ht_fix_file configure
}

src_compile() {
	econf || die "econf failed"
	# Bad configure script is forcing CFLAGS, so we pass our own
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin oer || die "dobin failed"
	dodoc CHANGELOG HELP README THANKS || die "dodoc failed"
	docinto sample-configuration
	dodoc sample-configuration/* || die "dodoc failed"
}

pkg_postinst() {
	elog
	elog "You can find a sample configuration file set in"
	elog "/usr/share/doc/${PF}/sample-configuration"
	elog
}
