# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti-spine/cacti-spine-0.8.7a.ebuild,v 1.8 2008/05/19 16:52:49 pva Exp $

WANT_AUTOCONF="latest"
inherit autotools

MY_PV=${PV/_p/-}
DESCRIPTION="Spine is a fast poller for Cacti (formerly known as Cactid)"
HOMEPAGE="http://cacti.net/spine_info.php"
SRC_URI="http://www.cacti.net/downloads/spine/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="net-analyzer/net-snmp
		virtual/mysql"
RDEPEND="${DEPEND}
		>net-analyzer/cacti-0.8.7"

src_unpack() {
	unpack ${A} ; cd "${S}"
	sed -i -e 's/^bin_PROGRAMS/sbin_PROGRAMS/' Makefile.am
	sed -i -e 's/wwwroot\/cacti\/log/var\/log/g' spine.h
	eaclocal
	eautoconf
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	exeinto usr/sbin ; doexe "${S}"/spine
	insinto etc/ ; insopts -m0640 -o root ; doins "${S}"/spine.conf
	dodoc ChangeLog INSTALL README
}

pkg_postinst() {
	ewarn "NOTE: If you upgraded from cactid, do not forgive to setup spine"
	ewarn "instead of cactid through web interface."
	ewarn
	elog "Please see cacti's site for installation instructions."
	elog "Theres no need to change the crontab for this, just"
	elog "read the instructions on how to implement it"
	elog
	elog "http://cacti.net/spine_install.php"
	echo
	ewarn "/etc/spine.conf should be readable by webserver, thus after you"
	ewarn "decide on webserver/webserver group do not forget to change it's"
	ewarn "group with the following command:"
	ewarn
	ewarn " # chown root:wwwgroup /etc/spine.conf"
	echo
}
