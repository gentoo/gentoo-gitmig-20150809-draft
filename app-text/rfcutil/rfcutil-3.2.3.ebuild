# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rfcutil/rfcutil-3.2.3.ebuild,v 1.9 2004/03/23 20:46:06 dragonheart Exp $

inherit eutils

MY_PN="rfc"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="RFC Util allows you to specify the number of an RFC, or a search
string, and it returns all related RFCs. It features command line switches to
spawn lynx or w3m to view the RFC, dump to file for offline viewing, or mail to
an address. It also allows local and remote lookups of port, service, or proto
numbers."
HOMEPAGE="http://www.dewn.com/rfc/"
SRC_URI="http://www.dewn.com/rfc/${MY_P}.tar.gz"

KEYWORDS="x86 sparc ppc"
SLOT="0"
LICENSE="as-is"

RDEPEND="dev-lang/perl
	net-www/lynx
	net-www/w3m"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${MY_P}.diff || die
}

src_compile() {
	einfo "Nothing to compile"
}

src_install () {
	newbin ${MY_P} ${MY_PN}
	doman ${MY_PN}.1
	dodoc CHANGELOG INSTALL KNOWN_BUGS README

	keepdir /var/cache/rfc
}

pkg_postinst () {
	einfo "Generating rfc-index"
	/usr/bin/rfc -i
	einfo "Gaarde suggests you make a cron.monthly to run the following:"
	einfo "   /usr/bin/rfc -i"
}

pkg_prerm () {
	rm /var/cache/rfc/* -f
}
