# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rfcutil/rfcutil-3.2.3.ebuild,v 1.1 2002/07/28 13:23:51 aliz Exp $

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

KEYWORDS="x86"
SLOT="0"
LICENSE="as-is"

src_compile() {
	patch -l -p0 < ${FILESDIR}/${MY_P}.gaarde || die
}

src_install () {
	newbin ${MY_P} ${MY_PN}
	doman ${MY_PN}.1
	dodoc CHANGELOG INSTALL KNOWN_BUGS README
	mkdir -p ${D}/var/cache/rfc/
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
