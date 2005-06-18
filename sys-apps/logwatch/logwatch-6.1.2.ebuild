# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/logwatch/logwatch-6.1.2.ebuild,v 1.1 2005/06/18 03:48:30 vapier Exp $

inherit eutils

DESCRIPTION="Analyzes and Reports on system logs"
HOMEPAGE="http://www.logwatch.org/"
SRC_URI="ftp://ftp.kaybee.org/pub/linux/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="virtual/cron
	virtual/mta
	dev-lang/perl
	dev-perl/Tie-IxHash
	dev-perl/Date-Calc
	virtual/mailx"
DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-emerge-applydate.patch
}

src_install() {
	dodir /etc/log.d/lib
	dodir /etc/log.d/conf/logfiles
	dodir /etc/log.d/conf/services
	dodir /etc/log.d/scripts/services
	dodir /etc/log.d/scripts/shared

	newsbin scripts/logwatch.pl logwatch.pl

	for i in scripts/logfiles/* ; do
		exeinto /etc/log.d/$i
		doexe $i/* || die "doexe $i failed"
	done

	exeinto /etc/log.d/lib
	doexe lib/*.pm

	exeinto /etc/log.d/scripts/services
	doexe scripts/services/*

	exeinto /etc/log.d/scripts/shared
	doexe scripts/shared/*

	insinto /etc/log.d/conf
	doins conf/logwatch.conf

	insinto /etc/log.d/conf/logfiles
	doins conf/logfiles/*

	insinto /etc/log.d/conf/services
	doins conf/services/*

	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/logwatch logwatch

	doman logwatch.8
	dodoc License project/CHANGES README HOWTO-Make-Filter
}
