# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/amanda/amanda-2.4.4.ebuild,v 1.12 2004/01/07 08:59:07 robbat2 Exp $

inherit eutils
DESCRIPTION="The Advanced Maryland Automatic Network Disk Archiver"
HOMEPAGE="http://www.amanda.org/"
SRC_URI="mirror://sourceforge/amanda/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc -sparc"
DEPEND="sys-libs/readline
		virtual/inetd
		virtual/mta
		app-arch/mt-st
		net-mail/mailx
		media-gfx/gnuplot
		sys-apps/gawk
		app-arch/tar
		sys-devel/autoconf
		sys-devel/automake
		dev-lang/perl
		sys-apps/mtx
		app-arch/dump
		net-mail/mailx
		samba? ( net-fs/samba )
		berkdb? ( sys-libs/db )
		gdbm? ( sys-libs/gdbm )
		xfs? ( sys-fs/xfsdump )"

IUSE="pic debug gdbm berkdb samba xfs"

S=${WORKDIR}/${P}

[ -z "${AMANDA_GROUP_GID}" ] && AMANDA_GROUP_GID=87
[ -z "${AMANDA_GROUP_NAME}" ] && AMANDA_GROUP_NAME=amanda
[ -z "${AMANDA_USER_NAME}" ] && AMANDA_USER_NAME=amanda
[ -z "${AMANDA_USER_UID}" ] && AMANDA_USER_UID=87
[ -z "${AMANDA_USER_SH}" ] && AMANDA_USER_SH=/bin/false
[ -z "${AMANDA_USER_HOMEDIR}" ] && AMANDA_USER_HOMEDIR=/var/spool/amanda
[ -z "${AMANDA_USER_GROUPS}" ] && AMANDA_USER_GROUPS=${AMANDA_GROUP_NAME}
# This installs Amanda, with the server. However, it could be a client,
# just specify an alternate server name in AMANDA_SERVER.
[ -z "${AMANDA_SERVER}" ] && AMANDA_SERVER=localhost
[ -z "${AMANDA_SERVER_TAPE}" ] && AMANDA_SERVER_TAPE="${AMANDA_SERVER}"
[ -z "${AMANDA_SERVER_INDEX}" ] && AMANDA_SERVER_INDEX="${AMANDA_SERVER}"
[ -z "${AMANDA_TAR_LISTDIR}" ] && AMANDA_TAR_LISTDIR=${AMANDA_USER_HOMEDIR}/tar-lists
[ -z "${AMANDA_CONFIG_NAME}" ] && AMANDA_CONFIG_NAME=DailySet1
[ -z "${AMANDA_TMPDIR}" ] && AMANDA_TMPDIR=${AMANDA_USER_HOMEDIR}/tmp

pkg_setup() {
	enewgroup ${AMANDA_GROUP_NAME} ${AMANDA_GROUP_GID}
	enewuser ${AMANDA_USER_NAME} ${AMANDA_USER_UID} ${AMANDA_USER_SH} ${AMANDA_USER_HOMEDIR} ${AMANDA_USER_GROUPS}
	echo >/dev/null
}

src_compile() {
	# fix bug #36316 
	addpredict /var/cache/samba/gencache.tdb

	local myconf
	cd ${S}

	[ -z "${AMANDA_DBMODE}" ]  || use gdbm && AMANDA_DBMODE=gdbm
	use berkdb && AMANDA_DBMODE=db
	[ -z "${AMANDA_DBMODE}" ] && AMANDA_DBMODE=text
	einfo "Using '${AMANDA_DBMODE}' style database"
	myconf="${myconf} --with-db=${AMANDA_DBMODE}"

	einfo "Using ${AMANDA_SERVER_TAPE} for tape server."
	myconf="${myconf} --with-tape-server=${AMANDA_SERVER_TAPE}"
	einfo "Using ${AMANDA_SERVER_INDEX} for index server."
	myconf="${myconf} --with-index-server=${AMANDA_SERVER_TAPE}"
	einfo "Using ${AMANDA_USER_NAME} for amanda user."
	myconf="${myconf} --with-user=${AMANDA_USER_NAME}"
	einfo "Using ${AMANDA_GROUP_NAME} for amanda group."
	myconf="${myconf} --with-group=${AMANDA_GROUP_NAME}"
	einfo "Using ${AMANDA_TAR_LISTDIR} as tar listdir."
	myconf="${myconf} --with-gnutar-listdir=${AMANDA_TAR_LISTDIR}"
	einfo "Using ${AMANDA_CONFIG_NAME} as default config name."
	myconf="${myconf} --with-config=${AMANDA_CONFIG_NAME}"
	einfo "Using ${AMANDA_TMPDIR} as Amanda temporary directory."
	myconf="${myconf} --with-tmpdir=${AMANDA_TMPDIR}"

	if [ -n "${AMANDA_PORTS_UDP}" ] && [ -n "${AMANDA_PORTS_TCP}" ] && [ -z "${AMANDA_PORTS_BOTH}" ] ; then
		eerror "If you want _both_ UDP and TCP ports, please use only the"
		eerror "AMANDA_PORTS environment variable for identical ports, or set"
		eerror "AMANDA_PORTS_BOTH."
		die "Bad port setup!"
	fi
	if [ -n "${AMANDA_PORTS_UDP}" ]; then
		einfo "Using UDP ports ${AMANDA_PORTS_UDP/,/-}"
		myconf="${myconf} --with-udpportrange=${AMANDA_PORTS_UDP}"
	fi
	if [ -n "${AMANDA_PORTS_TCP}" ]; then
		einfo "Using TCP ports ${AMANDA_PORTS_TCP/,/-}"
		myconf="${myconf} --with-tcpportrange=${AMANDA_PORTS_TCP}"
	fi
	if [ -n "${AMANDA_PORTS}" ]; then
		einfo "Using ports ${AMANDA_PORTS/,/-}"
		myconf="${myconf} --with-portrange=${AMANDA_PORTS}"
	fi

	# Extras
	# Speed option
	myconf="${myconf} --with-buffered-dump"
	# Debug
	myconf="${myconf} `use_with debug debugging`"
	# PIC
	myconf="${myconf} `use_with pic`"
	myconf="${myconf} --localstatedir=${AMANDA_USER_HOMEDIR}"

	use samba && myconf="${myconf} --with-smbclient=/usr/bin/smbclient" || myconf="${myconf} --without-smbclient"

	econf ${myconf} || die "econf failed!"
	emake || die "emake failed!"

	# Compile the tapetype program too
	cd tape-src
	emake tapetype || "emake tapetype failed!"

	dosed "s,/usr/local/bin/perl,/usr/bin/perl," ${S}/contrib/set_prod_link.pl
	perl ${S}/contrib/set_prod_link.pl

}


src_install() {
	make DESTDIR=${D} install || die

	into /usr
	newsbin tape-src/tapetype tapetype

	dodoc AUTHORS C* INSTALL NEWS README
	docinto example
	dodoc ${S}/example/*
	docinto docs
	dodoc ${S}/docs/*
	prepalldocs

	if use xfs; then
		dodir ${D}/var/xfsdump/inventory
		mkdir -p ${D}/var/xfsdump/inventory
	fi

	# einfo "Installing Amandahosts File for ${AMANDA_SERVER}"
	insinto ${AMANDA_USER_HOMEDIR}
	newins ${FILESDIR}/amanda-amandahosts .amandahosts
	dosed "s/__AMANDA_SERVER__/${AMANDA_SERVER}/" ${AMANDA_USER_HOMEDIR}/.amandahosts
	newins ${FILESDIR}/amanda-profile .profile

	# einfo "Installing Sample Daily Cron Job for Amanda"
	CRONDIR=/etc/cron.daily/
	exeinto ${CDRONDIR}
	newexe ${FILESDIR}/amanda-cron amanda
	dosed "s,__AMANDA_CONFIG_NAME__,${AMANDA_CONFIG_NAME},g" ${CRONDIR}/amanda
	fperms 644 ${CRONDIR}/amanda

	insinto /etc/amanda/lbl
	newins ${S}/example/3hole.ps 3hole.ps
	newins ${S}/example/8.5x11.ps 8.5x11.ps
	newins ${S}/example/DIN-A4.ps DIN-A4.ps
	newins ${S}/example/DLT.ps DLT.ps
	newins ${S}/example/EXB-8500.ps EXB-8500.ps
	newins ${S}/example/HP-DAT.ps HP-DAT.ps

	# Amanda example configs
	insinto /etc/amanda/example
	newins ${FILESDIR}/example_amanda.conf amanda.conf
	newins ${FILESDIR}/example_disklist disklist
	newins ${FILESDIR}/example_global.conf global.conf
	insinto /etc/amanda/example2
	newins ${S}/example/amanda.conf amanda.conf
	newins ${S}/example/disklist disklist

	# einfo "Installing Sample Daily Backup Configuration"
	insinto /etc/amanda/${AMANDA_CONFIG_NAME}
	fowners ${AMANDA_USER_NAME}:${AMANDA_GROUP_NAME} /etc/amanda
	fowners ${AMANDA_USER_NAME}:${AMANDA_GROUP_NAME} /etc/amanda/${AMANDA_CONFIG_NAME}
	fowners ${AMANDA_USER_NAME}:${AMANDA_GROUP_NAME} /etc/amanda/${AMANDA_CONFIG_NAME}/*
	fperms 700 /etc/amanda
	fperms 700 /etc/amanda/${AMANDA_CONFIG_NAME}

	local i
	for i in amandates dumpdates; do
		touch ${D}/etc/${i}
		fowners ${AMANDA_USER_NAME}:${AMANDA_GROUP_NAME} /etc/${i}
		fperms 600 /etc/${i}
	done

	dodir ${AMANDA_TAR_LISTDIR}
	dodir ${AMANDA_TMPDIR}
	dodir ${AMANDA_TMPDIR}/dumps
	dodir ${AMANDA_USER_HOMEDIR}/${AMANDA_CONFIG_NAME}
	fowners ${AMANDA_USER_NAME}:${AMANDA_GROUP_NAME} ${AMANDA_USER_HOMEDIR}
	fowners ${AMANDA_USER_NAME}:${AMANDA_GROUP_NAME} ${AMANDA_TAR_LISTDIR}
	fowners ${AMANDA_USER_NAME}:${AMANDA_GROUP_NAME} ${AMANDA_TMPDIR}
	fowners ${AMANDA_USER_NAME}:${AMANDA_GROUP_NAME} ${AMANDA_TMPDIR}/dumps
	fowners ${AMANDA_USER_NAME}:${AMANDA_GROUP_NAME} ${AMANDA_USER_HOMEDIR}/${AMANDA_CONFIG_NAME}
	fperms 700 ${AMANDA_USER_HOMEDIR}

	# DevFS
	insinto /etc/devfs.d
	newins ${FILESDIR}/amanda-devfs amanda

	if  [ -x "/usr/sbin/xinetd" ]; then
		# Installing Amanda Xinetd Services Definition
		insinto /etc/xinetd.d
		newins ${FILESDIR}/amanda-xinetd amanda
		dosed "s/__AMANDA_SERVER__/${AMANDA_SERVER}/g" /etc/xinetd.d/amanda
	else
		echo > ${D}/etc/amanda/inetd.amanda "amanda	  dgram   udp    wait    amanda  /usr/libexec/amanda/amandad    amandad"
		echo >> ${D}/etc/amanda/inetd.amanda "amandaidx stream  tcp    nowait  amanda  /usr/libexec/amanda/amindexd   amindexd"
		echo >> ${D}/etc/amanda/inetd.amanda "amidxtape stream  tcp    nowait  amanda  /usr/libexec/amanda/amidxtaped amidxtaped"
	fi
}

pkg_postinst() {
	einfo "You should configure Amanda in /etc/amanda now."
	if  [ -x "/usr/sbin/xinetd" ]; then
		einfo "Don't forget to check /etc/xinetd.d/amanda and restart"
		einfo "xinetd afterwards!"
	else
		einfo "No xinetd found. Config example for inetd is in /etc/amanda/inetd.amanda"
	fi
	einfo "NOTICE: If you need raw acces to partitions you need to add the"
	einfo "amanda user to the 'disk' group and uncomment following lines in"
	einfo "your /etc/devfs.d/amanda:"
	einfo "SCSI:"
	einfo "REGISTER   ^scsi/host.*/bus.*/target.*/lun.*/part[0-9]    PERMISSIONS root.disk 660"
	einfo "IDE:"
	einfo "REGISTER   ^ide/host.*/bus.*/target.*/lun.*/part[0-9]    PERMISSIONS root.disk 660"
}
