# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/amanda/amanda-2.4.4-r1.ebuild,v 1.13 2004/01/07 08:59:07 robbat2 Exp $

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
MYFILESDIR=${WORKDIR}/files
MYTMPDIR=${WORKDIR}/tmp
ENVDIR="/etc/env.d"
ENVDFILE="97amanda"
TMPENVFILE="${MYTMPDIR}/${ENVDFILE}"

amanda_variable_setup() {

	# Setting vars
	local currentamanda

	# Grab the current settings
	currentamanda="$(set | egrep "^AMANDA_" | xargs)"
	use debug && einfo "Current settings: ${currentamanda}"
	#for i in ${currentamanda}; do
	#	eval `eval echo ${i}`
	#	echo "Setting: ${i}"
	#done;

	# First we set the defaults
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
	# These are left empty by default
	[ -z "${AMANDA_PORTS_UDP}" ] && AMANDA_PORTS_UDP=
	[ -z "${AMANDA_PORTS_TCP}" ] && AMANDA_PORTS_TCP=
	[ -z "${AMANDA_PORTS_BOTH}" ] && AMANDA_PORTS_BOTH=
	[ -z "${AMANDA_PORTS}" ] && AMANDA_PORTS=

	# This one is a little more complicated
	# The priority list is this:
	# 1. 'Berkely DB style' (only if USE="berkdb")
	# 2. 'GDBM style' (only if USE="gdbm")
	# 3. 'Text style'
	[ -z "${AMANDA_DBMODE}" ] && use berkdb && AMANDA_DBMODE=db
	[ -z "${AMANDA_DBMODE}" ] && use gdbm && AMANDA_DBMODE=gdbm
	[ -z "${AMANDA_DBMODE}" ] && AMANDA_DBMODE=text

	# Now pull in the old stuff
	if [ -f "${ENVDFILE}" ]; then
		# We don't just source it as we don't want everything in there.
		eval $(egrep "^AMANDA_" ${ENVDIR}/${ENVDFILE})
	fi

	# Re-apply the new settings if any
	[ -n "${currentamanda}" ] && eval `echo "${currentamanda}"`

}

pkg_setup() {
	# Now add users if needed
	amanda_variable_setup
	enewgroup ${AMANDA_GROUP_NAME} ${AMANDA_GROUP_GID}
	enewuser ${AMANDA_USER_NAME} ${AMANDA_USER_UID} ${AMANDA_USER_SH} ${AMANDA_USER_HOMEDIR} ${AMANDA_USER_GROUPS}
}

src_unpack() {
	unpack ${A}
	amanda_variable_setup
	# places for us to work in
	mkdir -p ${MYFILESDIR} ${MYTMPDIR}
	# Now we store the settings we just created
	set | egrep "^AMANDA_" > ${TMPENVFILE}
}

src_compile() {
	# fix bug #36316
	addpredict /var/cache/samba/gencache.tdb

	[ ! -f "${TMPENVFILE}" ] && die "Variable setting file (${TMPENVFILE}) should exist!"
	source ${TMPENVFILE}
	local myconf
	cd ${S}

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
	# Where to put our files
	myconf="${myconf} --localstatedir=${AMANDA_USER_HOMEDIR}"

	# Samba support
	use samba && myconf="${myconf} --with-smbclient=/usr/bin/smbclient" || myconf="${myconf} --without-smbclient"

	econf ${myconf} || die "econf failed!"
	emake || die "emake failed!"

	# Compile the tapetype program too
	# This is deprecated, use amtapetype instead!
	# cd tape-src
	# emake tapetype || die "emake tapetype failed!"

	# Only needed if you we do versioning
	#dosed "s,/usr/local/bin/perl,/usr/bin/perl," ${S}/contrib/set_prod_link.pl
	#perl ${S}/contrib/set_prod_link.pl

}


src_install() {
	[ ! -f "${TMPENVFILE}" ] && die "Variable setting file (${TMPENVFILE}) should exist!"
	source ${TMPENVFILE}

	einfo "Doing stock install"
	make DESTDIR=${D} install || die

	# Prepare our custom files
	einfo "Building custom configuration files"
	cp ${FILESDIR}/amanda-* ${MYFILESDIR}
	local i # our iterator
	local sedexpr # var for sed expr
	sedexpr=''
	for i in AMANDA_GROUP_GID AMANDA_GROUP_NAME AMANDA_USER_NAME AMANDA_USER_UID AMANDA_USER_SH AMANDA_USER_HOMEDIR AMANDA_USER_GROUPS AMANDA_SERVER AMANDA_SERVER_TAPE AMANDA_SERVER_INDEX AMANDA_TAR_LISTDIR AMANDA_CONFIG_NAME AMANDA_TMPDIR AMANDA_PORTS_UDP AMANDA_PORTS_TCP AMANDA_PORTS_BOTH AMANDA_PORTS; do
		local val
		eval "val=\"\${${i}}\""
		sedexpr="${sedexpr}s|__${i}__|${val}|g;"
	done
	#einfo "Compiled SED expression: '${sedexpr}'"

	# now apply the sed expr
	for i in ${FILESDIR}/amanda-* ; do
		local filename
		filename=`basename ${i}`
		#einfo "Applying compiled SED expression to ${filename}"
		sed -re "${sedexpr}" <${i} >${MYFILESDIR}/${filename}
	done



	# Build the envdir file
	# Don't forget this..
	einfo "Building environment file"
	echo "# These settings are what was present in the environment when this" >>${MYFILESDIR}/${ENVDFILE}
	echo "# Amanda was compiled.  Changing anything below this comment will" >>${MYFILESDIR}/${ENVDFILE}
	echo "# have no effect on your application, but it merely exists to" >>${MYFILESDIR}/${ENVDFILE}
	echo "# preserve them for your next emerge of Amanda" >>${MYFILESDIR}/${ENVDFILE}
	cat ${TMPENVFILE} | sed "s,=\$,='',g" >>${MYFILESDIR}/${ENVDFILE}

	into /usr

	# Depreacted, use amtapetype instead
	#einfo "Installing tapetype utility"
	#newsbin tape-src/tapetype tapetype

	# docs
	einfo "Installing documentation"
	dodoc AUTHORS C* INSTALL NEWS README
	# Clean up some bits
	dodoc ${D}/usr/share/amanda/*
	rm -rf ${D}/usr/share/amanda
	# our inetd sample
	einfo "Installing standard inetd sample"
	dodoc ${MYFILESDIR}/amanda-inetd.amanda.sample
	# Stock extra docs
	docinto docs
	dodoc ${S}/docs/*
	# Labels
	einfo "Installing labels"
	docinto labels
	dodoc ${S}/example/3hole.ps
	dodoc ${S}/example/8.5x11.ps
	dodoc ${S}/example/DIN-A4.ps
	dodoc ${S}/example/DLT.ps
	dodoc ${S}/example/EXB-8500.ps
	dodoc ${S}/example/HP-DAT.ps
	# Amanda example configs
	einfo "Installing example configurations"
	docinto example
	dodoc ${S}/example/*
	docinto example1
	newdoc ${FILESDIR}/example_amanda.conf amanda.conf
	newdoc ${FILESDIR}/example_disklist disklist
	newdoc ${FILESDIR}/example_global.conf global.conf
	docinto example2
	newdoc ${S}/example/amanda.conf amanda.conf
	newdoc ${S}/example/disklist disklist
	# Compress it all
	prepalldocs

	# Just make sure it exists for XFS to work...
	use xfs && keepdir ${D}/var/xfsdump/inventory

	insinto /etc/amanda
	einfo "Installing .amandahosts File for ${AMANDA_USER_NAME} user"
	newins ${MYFILESDIR}/amanda-amandahosts amandahosts
	dosym /etc/amanda/amandahosts ${AMANDA_USER_HOMEDIR}/.amandahosts
	insinto ${AMANDA_USER_HOMEDIR}
	einfo "Installing .profile for ${AMANDA_USER_NAME} user"
	newins ${MYFILESDIR}/amanda-profile .profile

	einfo "Installing Sample Daily Cron Job for Amanda"
	CRONDIR=/etc/cron.daily/
	exeinto ${CRONDIR}
	newexe ${MYFILESDIR}/amanda-cron amanda
	# Not excetuable by default
	fperms 644 ${CRONDIR}/amanda

	insinto /etc/amanda/${AMANDA_CONFIG_NAME}
	keepdir /etc/amanda
	keepdir /etc/amanda/${AMANDA_CONFIG_NAME}

	local i
	for i in ${AMANDA_USER_HOMEDIR} ${AMANDA_TAR_LISTDIR} ${AMANDA_TMPDIR} ${AMANDA_TMPDIR}/dumps ${AMANDA_USER_HOMEDIR}/${AMANDA_CONFIG_NAME} /etc/amanda /etc/amanda/${AMANDA_CONFIG_NAME}; do
		einfo "Securing directory (${i})"
		dodir ${i}
		keepdir ${i}
		fowners ${AMANDA_USER_NAME}:${AMANDA_GROUP_NAME} ${i}
		fperms 700 ${i}
	done

	for i in amandates dumpdates; do
		einfo "Creating inital Amanda file (${i})"
		touch ${D}/etc/${i}
		fowners ${AMANDA_USER_NAME}:${AMANDA_GROUP_NAME} /etc/${i}
		fperms 600 /etc/${i}
	done

	# DevFS
	einfo "Installing DevFS config file"
	insinto /etc/devfs.d
	newins ${MYFILESDIR}/amanda-devfs amanda

	# Env.d
	einfo "Installing environment config file"
	insinto /etc/env.d
	doins ${MYFILESDIR}/${ENVDFILE}

	# Installing Amanda Xinetd Services Definition
	einfo "Installing xinetd service file"
	insinto /etc/xinetd.d
	newins ${MYFILESDIR}/amanda-xinetd amanda

}

pkg_postinst() {
	einfo "You should configure Amanda in /etc/amanda now."
	echo
	einfo "If you use xinetd, Don't forget to check /etc/xinetd.d/amanda"
	einfo "and restart xinetd afterwards!"
	echo
	einfo "Otherwise, please look at /usr/share/doc/${P}/inetd.amanda.sample"
	einfo "as an example of how to configure your inetd."
	echo
	einfo "NOTICE: If you need raw acces to partitions you need to add the"
	einfo "amanda user to the 'disk' group and uncomment following lines in"
	einfo "your /etc/devfs.d/amanda:"
	einfo "SCSI:"
	einfo "REGISTER   ^scsi/host.*/bus.*/target.*/lun.*/part[0-9]    PERMISSIONS root.disk 660"
	einfo "IDE:"
	einfo "REGISTER   ^ide/host.*/bus.*/target.*/lun.*/part[0-9]    PERMISSIONS root.disk 660"
}
