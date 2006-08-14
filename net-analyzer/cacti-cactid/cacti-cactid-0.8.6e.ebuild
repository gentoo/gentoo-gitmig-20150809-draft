# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti-cactid/cacti-cactid-0.8.6e.ebuild,v 1.4 2006/08/14 09:46:08 dragonheart Exp $

DESCRIPTION="Cactid is a poller for Cacti that primarily strives to be as fast
as possible"
HOMEPAGE="http://cacti.net/cactid_info.php"
SRC_URI="http://www.cacti.net/downloads/cactid/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc x86"
IUSE=""

DEPEND="net-analyzer/net-snmp
		net-analyzer/rrdtool
		!>=dev-db/mysql-5
		dev-db/mysql
		>=sys-devel/autoconf-2.53"
RDEPEND="net-analyzer/cacti"

src_unpack() {
	unpack ${A} ; cd ${S}
	sed -i -e 's/^bin_PROGRAMS/sbin_PROGRAMS/' Makefile.am
	sed -i -e 's/mysqlclient/mysqlclient_r/g' configure.ac
	sed -i -e 's/wwwroot\/cacti\/log/var\/log/g' cactid.h
}

src_compile() {
	export WANT_AUTOCONF=2.5
	aclocal || die "aclocal failed"
	autoconf || die "autoconf failed"
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	exeinto usr/sbin ; doexe ${S}/cactid
	insinto etc/ ; insopts -m0640 -o root -g apache ; doins ${S}/cactid.conf
	dodoc CHANGELOG INSTALL README
}

pkg_postinst() {
	einfo "Please see cacti's site for installation instructions."
	einfo "Theres no need to change the crontab for this, just"
	einfo "read the instructions on how to implement it"
	einfo
	einfo "http://cacti.net/cactid_install.php"
}
