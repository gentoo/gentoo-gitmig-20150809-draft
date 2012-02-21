# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rfcutil/rfcutil-3.2.3-r1.ebuild,v 1.2 2012/02/21 13:38:37 ago Exp $

EAPI=4

inherit eutils

MY_PN="rfc"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="return all related RFCs based upon a number or a search string"
HOMEPAGE="http://www.dewn.com/rfc/"
SRC_URI="http://www.dewn.com/rfc/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	|| ( www-client/lynx virtual/w3m )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${MY_P}.diff \
		"${FILESDIR}"/${MY_P}-index.patch
}

src_install() {
	newbin ${MY_P} ${MY_PN}
	doman ${MY_PN}.1
	dodoc CHANGELOG KNOWN_BUGS README
	keepdir /var/cache/rfc
}

pkg_postinst() {
	elog "Gaarde suggests you make a cron.monthly to run the following:"
	elog "   /usr/bin/rfc -i"
}

pkg_prerm() {
	rm -f "${ROOT}"/var/cache/rfc/*
}
