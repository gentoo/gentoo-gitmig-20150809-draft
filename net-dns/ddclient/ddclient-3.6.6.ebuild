# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/ddclient/ddclient-3.6.6.ebuild,v 1.2 2005/04/04 13:44:05 seemant Exp $

inherit eutils

DESCRIPTION="A perl based client for dyndns"
HOMEPAGE="http://burry.ca:4141/ddclient/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/perl"

pkg_setup() {
	enewgroup ddclient -1
	enewuser  ddclient -1 /bin/false /dev/null ddclient
}

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${PN}-mss1.diff
	epatch ${FILESDIR}/${PN}-daemon0inconfig.diff

	sed -i 's:/var/run/ddclient.pid:/var/run/ddclient/ddclient.pid:' \
		sample-etc_ddclient.conf
}

src_install() {
	dosbin ddclient || die "dosbin"
	dodoc README* Change* COPYRIGHT
	dodoc sample-etc_[c-p]*

	newinitd ${FILESDIR}/ddclient.init ddclient
	
	insinto /etc/ddclient
	insopts -m 0640 -g ddclient -o root
	newins sample-etc_ddclient.conf ddclient.conf

	diropts -m 0755 -g ddclient -o ddclient
	keepdir /var/run/ddclient
}

pkg_postinst() {
	echo
	einfo
	ewarn "The files in ${ROOT}etc/ddclient will be chowned to"
	ewarn "root:ddclient, and chmodded to 640:"
	ewarn "(user/group read; user write)"
	ewarn "Please run etc-update and update your initscript to take"
	ewarn "advantage of non-root permissions on the daemon"
	ewarn "Further, please note that your config files must be owned"
	ewarn "by the user ddclient or have group ownership by ddclient."
	ewarn "In other words, please follow the ownership/permissions scheme"
	ewarn "that has been laid out in /etc/ddclient for you."
	einfo
	ebeep
	epause
}
