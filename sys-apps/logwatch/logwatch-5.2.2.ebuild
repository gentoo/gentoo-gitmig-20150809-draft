# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/logwatch/logwatch-5.2.2.ebuild,v 1.4 2004/07/21 21:21:47 tgall Exp $

DESCRIPTION="Analyzes and Reports on system logs"
HOMEPAGE="http://www.logwatch.org/"
SRC_URI="ftp://ftp.kaybee.org/pub/linux/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ppc64"
IUSE=""

RDEPEND="virtual/libc
	virtual/cron
	virtual/mta
	dev-lang/perl
	mail-client/mailx"
DEPEND=""

src_install() {
	dodir /etc/log.d/lib
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

	doman logwatch.8
	dodoc License project/CHANGES README HOWTO-Make-Filter
}

pkg_postinst() {
	einfo
	einfo "you have to manually add ${PN} to cron..."
	einfo "0 0 * * * /usr/sbin/logwatch.pl 2>&1 > /dev/null"
	einfo
}
