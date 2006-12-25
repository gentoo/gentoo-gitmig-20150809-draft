# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-antivirus/bitdefender-console/bitdefender-console-7.1.ebuild,v 1.1 2006/12/25 19:20:25 ticho Exp $

MY_P="BitDefender-Console-Antivirus-${PV}-3.linux-gcc3x.i386.run"
S="${WORKDIR}/i386"

DESCRIPTION="BitDefender console antivirus"
HOMEPAGE="http://www.bitdefender.com/"
SRC_URI="http://download.bitdefender.com/unices/old/linux/free/bitdefender-console/en/${MY_P}"

DEPEND="app-arch/tar
	app-arch/gzip"
RDEPEND="virtual/libc
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-1.0
		app-emulation/emul-linux-x86-compat )
	!amd64? ( || ( =sys-libs/libstdc++-v3-3.3* =sys-devel/gcc-3.3* ) )"
PROVIDE="virtual/antivirus"

SLOT="0"
LICENSE="as-is"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

src_unpack () {
	#Extract the tgz achive contained in MY_P
	SKIP=`sed -n '/^\x1F/q;p' < ${DISTDIR}/${MY_P} | wc -c`
	dd if=${DISTDIR}/${MY_P} ibs=1 skip=$SKIP 2> /dev/null | tar -xz || die "Failed to extract from archive"
}

src_install() {
	local curn
	local newn
	local is_newer=0

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

	dodir /var/bdc
	dodir /var/bdc/infected
	keepdir /var/bdc/infected
	dodir /var/bdc/suspected
	keepdir /var/bdc/suspected

	insopts -m 644
	doins bdc.ini *.so

	dodir /opt/bdc/Plugins
	insinto /opt/bdc/Plugins
	doins Plugins/*

	doman man/man?/*
	dodoc doc/*
}

pkg_preinst() {
	[[ -f /opt/bdc/Plugins/update.txt ]] && rm -f /opt/bdc/Plugins/*
}

pkg_postinst() {
	einfo You should update virus database by running bdc --update
	[ -x /sbin/chpax ] && {
		echo
		ewarn "Disabling some PaX restrictions (\`/sbin/chpax -spm /opt/bdc/bdc\`, see bug #83695)"
		/sbin/chpax -spm /opt/bdc/bdc
		echo
	}
}

pkg_postrm() {
	# Remove leftover datafiles (their mtimes tend to change as user updates
	# them).
	[[ ! -x /opt/bdc/bdc ]] && rm -rf /opt/bdc
}
