# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-antivirus/bitdefender-console/bitdefender-console-7.0.1.ebuild,v 1.2 2004/11/20 15:53:30 ticho Exp $

IUSE=""

MY_P=BitDefender-Console-Antivirus-${PV}-3.linux-gcc3x.i586.run
S=${WORKDIR}/i386

DESCRIPTION="BitDefender console antivirus"
HOMEPAGE="http://www.bitdefender.com/"
SRC_URI="ftp://ftp.bitdefender.com/pub/linux/free/bitdefender-console/en/${MY_P}"

DEPEND="app-arch/tar
	app-arch/gzip"
RDEPEND="virtual/libc"
PROVIDE="virtual/antivirus"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"

src_unpack () {
	#Extract the tgz achive contained in MY_P
	SKIP=`sed -n '/^\x1F/q;p' < ${DISTDIR}/${MY_P} | wc -c`
	dd if=${DISTDIR}/${MY_P} ibs=1 skip=$SKIP 2> /dev/null | tar -xz || die "Failed to extract from archive"
}

src_install ()
{
	cd ${S}

	INSTALLDIR=/opt
	QUARDIR=/var/bdc
	INIFILE=bdc.ini

	(
		dodir ${QUARDIR} &&
		dodir ${QUARDIR}/infected &&
		dodir ${QUARDIR}/suspected
	) || die "Unable to create quarantine directories"

	cd opt/bdc
	echo "InfectedFolder = ${QUARDIR}/infected" >> $INIFILE
	echo "SuspectedFolder = ${QUARDIR}/suspected" >> $INIFILE

	insinto /opt/bdc
	insopts -m 755
	doins bdc
	dodir /usr/bin
	dosym /opt/bdc/bdc /usr/bin/bdc

	insopts -m 644
	doins bdc.ini *.so
	insinto /opt/bdc/Plugins
	doins Plugins/*

	doman man/*
	dodoc doc/*
}

pkg_postinst ()
{
	einfo You should upgrade  virus database by running bdc --update
}
