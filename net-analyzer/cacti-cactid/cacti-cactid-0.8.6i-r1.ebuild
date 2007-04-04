# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti-cactid/cacti-cactid-0.8.6i-r1.ebuild,v 1.4 2007/04/04 16:57:07 gustavoz Exp $

WANT_AUTOCONF="latest"
inherit autotools

MY_PV=${PV/_p/-}
DESCRIPTION="Cactid is a poller for Cacti that primarily strives to be as fast
as possible"
HOMEPAGE="http://cacti.net/cactid_info.php"
SRC_URI="http://www.cacti.net/downloads/cactid/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ppc64 sparc x86"
IUSE=""

DEPEND="net-analyzer/net-snmp
		virtual/mysql"
RDEPEND="${DEPEND}
		net-analyzer/cacti"

src_unpack() {
	unpack ${A} ; cd "${S}"
	sed -i -e 's/^bin_PROGRAMS/sbin_PROGRAMS/' Makefile.am
	sed -i -e 's/mysqlclient/mysqlclient_r/g' configure.ac
	sed -i -e 's/wwwroot\/cacti\/log/var\/log/g' cactid.h
}

src_compile() {
	eaclocal
	eautoconf
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	exeinto usr/sbin ; doexe "${S}"/cactid
	insinto etc/ ; insopts -m0640 -o root ; doins "${S}"/cactid.conf
	dodoc ChangeLog INSTALL README
}

pkg_postinst() {
	einfo "Please see cacti's site for installation instructions."
	einfo "Theres no need to change the crontab for this, just"
	einfo "read the instructions on how to implement it"
	einfo
	einfo "http://cacti.net/cactid_install.php"
	echo
	ewarn "/etc/cactid.conf should be readable by webserver, thus after you"
	ewarn "decide on webserver/webserver group do not forgive to change it's"
	ewarn "group with the following command:"
	ewarn
	ewarn " # chown root:wwwgroup /etc/cactid.conf"
	echo
}
