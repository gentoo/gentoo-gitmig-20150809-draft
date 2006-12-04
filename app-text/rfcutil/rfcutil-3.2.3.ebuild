# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rfcutil/rfcutil-3.2.3.ebuild,v 1.25 2006/12/04 21:16:58 eroyf Exp $

inherit eutils

MY_PN="rfc"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="return all related RFCs based upon a number or a search string"
HOMEPAGE="http://www.dewn.com/rfc/"
SRC_URI="http://www.dewn.com/rfc/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 mips ppc ppc-macos ppc64 sparc x86"
IUSE=""

RDEPEND="dev-lang/perl
	|| ( www-client/lynx virtual/w3m )"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${MY_P}.diff
}

src_install() {
	newbin ${MY_P} ${MY_PN} || die
	doman ${MY_PN}.1
	dodoc CHANGELOG KNOWN_BUGS README
	keepdir /var/cache/rfc
}

pkg_postinst() {
	[[ ${ROOT} != "/" ]] && return 0
	einfo "Generating rfc-index"
	/usr/bin/rfc -i
	einfo "Gaarde suggests you make a cron.monthly to run the following:"
	einfo "   /usr/bin/rfc -i"
}

pkg_prerm() {
	rm -f "${ROOT}"/var/cache/rfc/*
}
