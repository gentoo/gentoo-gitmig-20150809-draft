# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti-cactid/cacti-cactid-0.9_pre20050528.ebuild,v 1.1 2005/05/28 17:01:55 ramereth Exp $

DESCRIPTION="Cactid is a poller for Cacti that primarily strives to be as fast
as possible"
HOMEPAGE="http://cacti.net/cactid_info.php"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

DEPEND="net-analyzer/net-snmp
		net-analyzer/rrdtool
		dev-db/mysql
		>=sys-devel/autoconf-2.53"
RDEPEND="net-analyzer/cacti"

S=${WORKDIR}/cactid_unix

src_unpack() {
	unpack ${A} ; cd ${S}
	sed -i -e 's/^bin_PROGRAMS/sbin_PROGRAMS/' Makefile.am
	sed -i -e 's/mysqlclient/mysqlclient_r/g' configure.ac
	sed -i -e 's/wwwroot\/cacti\/log/var\/log/g' cactid.h
}

src_compile() {
	export WANT_AUTOCONF=2.53
	aclocal || die "aclocal failed"
	autoconf || die "autoconf failed"
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	exeinto usr/sbin ; doexe ${S}/cactid
	insinto etc/ ; insopts -m0640 -o root -g apache
	newins ${S}/cactid.conf.dist cactid.conf
	dodoc CHANGELOG INSTALL README
}

pkg_postinst() {
	einfo "Please see cacti's site for installation instructions."
	einfo "Theres no need to change the crontab for this, just"
	einfo "read the	instructions on how to implement it"
	einfo ""
	einfo "http://cacti.net/cactid_install.php"
}
