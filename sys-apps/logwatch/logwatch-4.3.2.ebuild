# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/logwatch/logwatch-4.3.2.ebuild,v 1.1 2003/04/11 06:06:38 jhhudso Exp $

DESCRIPTION="Analyzes and Reports on system logs"
HOMEPAGE="http://www.logwatch.org"
SRC_URI="ftp://ftp.kaybee.org/pub/linux/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc
	virtual/cron
	virtual/mta
	dev-lang/perl
	net-mail/mailx"
RDEPEND=""

src_install() {
	dodir /etc/log.d/conf/logfiles
	dodir /etc/log.d/conf/services
	dodir /etc/log.d/scripts/services
	dodir /etc/log.d/scripts/shared

	newsbin scripts/logwatch.pl logwatch.pl

	for i in scripts/logfiles/* ; do
		if [ $(ls $i | wc -l) -ne 0 ] ; then
			exeinto /etc/log.d/$i
			doexe $i/*
		fi
	done

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

	doman logwatch.8
	dodoc License project/CHANGES project/TODO README HOWTO-Make-Filter
}

pkg_postinst() {
	# this will avoid duplicate entries in the crontab
	if [ "`grep logwatch.pl ${ROOT}var/spool/cron/crontabs/root`" == "" ];
	then
		einfo "adding to cron..."
		echo "0 0 * * * ${ROOT}usr/sbin/logwatch.pl 2>&1 > /dev/null" \
			>> ${ROOT}var/spool/cron/crontabs/root
	fi
}

pkg_postrm() {
	# this fixes a bug when logwatch package gets updated
	if [ "`ls -d ${ROOT}var/db/pkg/sys-apps/logwatch* \
		| wc -l | tail -c 2`" -lt 2 ];
	then
		sed "/^0.*\/usr\/sbin\/logwatch.*null$/d" \
			${ROOT}var/spool/cron/crontabs/root \
			> ${ROOT}var/spool/cron/crontabs/root.new
		mv --force ${ROOT}var/spool/cron/crontabs/root.new \
			${ROOT}var/spool/cron/crontabs/root
	fi
}
