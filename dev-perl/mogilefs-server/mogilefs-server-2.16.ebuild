# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mogilefs-server/mogilefs-server-2.16.ebuild,v 1.1 2007/05/16 11:11:17 robbat2 Exp $

inherit perl-module

DESCRIPTION="Server for the MogileFS distributed file system"
HOMEPAGE="http://www.danga.com/mogilefs/"
SRC_URI="mirror://cpan/authors/id/B/BR/BRADFITZ/${P}.tar.gz"

IUSE="mysql sqlite"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

# Upstream site recommends this,
# but it breaks Perlbal
# dev-perl/Perlbal-XS-HTTPHeaders
DEPEND="dev-perl/Net-Netmask
		>=dev-perl/Danga-Socket-1.57
		>=dev-perl/Sys-Syscall-0.22
		>=dev-perl/Perlbal-1.57
		dev-perl/IO-AIO
		dev-perl/Gearman-Server
		dev-perl/Gearman-Client-Async
		dev-perl/libwww-perl
		dev-perl/Cache-Memcached
		mysql? ( dev-perl/DBD-mysql )
		sqlite? ( dev-perl/DBD-SQLite )
		dev-lang/perl"
mydoc="CHANGES TODO"

# You need a local MySQL server for this
#SRC_TEST="do"

PATCHES="${FILESDIR}/${PN}-2.16-Use-saner-name-in-process-listing.patch"

MOGILE_USER="mogile"

pkg_setup() {
	# Warning! It is important that the uid is constant over Gentoo machines
	# As mogilefs may be used with non-local block devices that move!
	enewuser ${MOGILE_USER} 460 -1 -1
}

src_install() {
	perl-module_src_install || die "perl-module_src_install failed"
	cd ${S}

	newconfd ${FILESDIR}/mogilefsd-conf.d-2.16 mogilefsd
	newinitd ${FILESDIR}/mogilefsd-init.d-2.16 mogilefsd

	newconfd ${FILESDIR}/mogstored-conf.d-2.16 mogstored
	newinitd ${FILESDIR}/mogstored-init.d-2.16 mogstored
	
	diropts -m 700 -o ${MOGILE_USER}
	keepdir /var/run/mogile
	keepdir /var/mogdata
	keepdir /mnt/mogilefs
	diropts -m 755 -o root

	dodir /etc/mogilefs
	insinto /etc/mogilefs
	insopts -m 600 -o root -g ${MOGILE_USER}
	newins ${FILESDIR}/mogilefsd.conf-2.16 mogilefsd.conf
	newins ${FILESDIR}/mogstored.conf-2.16 mogstored.conf
}

pkg_postinst() {
	chmod 640 ${ROOT}/etc/mogilefs/{mogilefsd,mogstored}.conf
	chown root:${MOGILE_USER} ${ROOT}/etc/mogilefs/{mogilefsd,mogstored}.conf
}
