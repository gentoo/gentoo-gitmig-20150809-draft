# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/logwatch/logwatch-4.3.1-r1.ebuild,v 1.1 2003/05/02 06:47:50 jhhudso Exp $

S=${WORKDIR}/${P}
DESCRIPTION="LogWatch, a customizable log analysis system"
SRC_URI="ftp://ftp.kaybee.org/pub/old/linux/${P}.tar.gz"
HOMEPAGE="http://www.logwatch.org/"

DEPEND="virtual/glibc
		virtual/cron
		virtual/mta
		dev-lang/perl
		net-mail/mailx"

SLOT="0"
KEYWORDS="~x86"
LICENSE="as-is"
IUSE=""
RDEPEND=""

src_install() {
	dodir /usr/share/logwatch
	dodir /usr/share/logwatch/conf
	dodir /usr/share/logwatch/conf/logfiles
	dodir /usr/share/logwatch/conf/services
	dodir /usr/share/logwatch/scripts
	dodir /usr/share/logwatch/scripts/services
	dodir /usr/share/logwatch/scripts/shared

	# correct install directory into script
	cat ${S}/scripts/logwatch.pl | sed -e "s/my \$BaseDir = \"\/etc\/log.d\";/my \$BaseDir = \"\/usr\/share\/logwatch\";/" > ${S}/scripts/logwatch.tmp_install
	exeinto /usr/share/logwatch/scripts
	newexe scripts/logwatch.tmp_install logwatch.pl
	exeinto /usr/share/logwatch/scripts/logfiles
	for i in scripts/logfiles/* ; do
		if [ $(ls $i | wc -l) -ne 0 ] ; then
			file="`echo $i | awk -F/ '{ print $3 }'`"
			dodir /usr/share/logwatch/scripts/logfiles/$file

			exeinto /usr/share/logwatch/scripts/logfiles/$file
			for l in scripts/logfiles/$file/* ; do
				subfile="`echo $l | awk -F/ '{ print $4 }'`"
				newexe $l $subfile
			done
		fi
	done

	exeinto /usr/share/logwatch/scripts/services
	for i in scripts/services/* ; do
			file="`echo $i | awk -F/ '{ print $3 }'`"
			newexe $i $file
	done

	exeinto /usr/share/logwatch/scripts/shared
	for i in scripts/shared/* ; do
			file="`echo $i | awk -F/ '{ print $3 }'`"
			newexe $i $file
	done

	insinto /usr/share/logwatch/conf
	doins conf/logwatch.conf

	insinto /usr/share/logwatch/conf/logfiles
	for i in conf/logfiles/* ; do
		doins $i
	done

	insinto /usr/share/logwatch/conf/services
	for i in conf/services/* ; do
			doins $i
	done

	dodoc README License HOWTO-Make-Filter
	doman logwatch.8
	}

pkg_postinst() {
	einfo "creating a symlink for configuration directory..."
	ln -snf ${ROOT}usr/share/logwatch/conf ${ROOT}etc/logwatch

	einfo "adding executable to path..."
	ln -sf ${ROOT}usr/share/logwatch/scripts/logwatch.pl ${ROOT}usr/bin/logwatch

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

	rm -f ${ROOT}etc/logwatch
	rm -f ${ROOT}usr/bin/logwatch
}


