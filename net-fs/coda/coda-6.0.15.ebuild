# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/coda/coda-6.0.15.ebuild,v 1.11 2011/03/28 08:41:56 ssuominen Exp $

inherit autotools eutils

KEYWORDS="~ppc x86"

DESCRIPTION="Coda is an advanced networked filesystem developed at Carnegie Mellon Uni."
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="http://www.coda.cs.cmu.edu/pub/coda/src/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="kerberos ssl"

# partly based on the deps suggested by Mandrake's RPM, and/or on my current versions
# Also, definely needs coda.h from linux-headers.
RDEPEND=">=sys-libs/lwp-2.1
	>=net-libs/rpc2-2.0
	>=sys-libs/rvm-1.11
	>=sys-libs/db-3
	>=sys-libs/ncurses-4
	>=sys-libs/readline-3
	>=dev-lang/perl-5.8
	kerberos? ( virtual/krb5 )
	ssl? ( dev-libs/openssl )"

DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-devel/bison
	sys-apps/grep
	virtual/os-headers"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-mit-krb5-struct.patch
}

src_compile() {
	local myflags=""

	use kerberos && myflags="${myflags} --with-krb5"
	use ssl && myflags="${myflags} --with-openssl"

	econf ${myflags} || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	#these crazy makefiles dont seem to use DESTDIR, but they do use these...
	# (except infodir, but no harm in leaving it there)
	# see Makeconf.setup in the package

	#Also note that for Coda, we need to do "make client-install" for
	# the client, and "make server-install" for the server.
	#...you can find out about this from ./configs/Makerules
	emake \
		CINIT-SCRIPTS="" \
		prefix="${D}"/usr \
		sysconfdir="${D}"/etc/coda \
		mandir="${D}"/usr/share/man \
		infodir="${D}"/usr/share/info \
		oldincludedir="${D}"/usr/include client-install || die "emake client-install failed"

	emake \
		SINIT-SCRIPTS="" \
		prefix="${D}"/usr \
		sysconfdir="${D}"/etc/coda \
		mandir="${D}"/usr/share/man \
		infodir="${D}"/usr/share/info \
		oldincludedir="${D}"/usr/include server-install || die "emake server-install failed"

	dodoc README* ChangeLog CREDITS

	doinitd "${FILESDIR}"/${PV}/venus
	doinitd "${FILESDIR}"/${PV}/coda-update
	doinitd "${FILESDIR}"/${PV}/codasrv
	doinitd "${FILESDIR}"/${PV}/auth2

	sed -i -e "s,^#vicedir=/.*,vicedir=/var/lib/vice," \
		"${D}"/etc/coda/server.conf.ex

	sed -i -e "s,^#mountpoint=/.*,mountpoint=/mnt/coda," \
		"${D}"/etc/coda/venus.conf.ex

	# Fix conflict with backup.sh from tar
	mv -f "${D}"/usr/sbin/backup{,-coda}.sh

	dodir /var/lib/vice
	dodir /mnt/coda
	dodir /usr/coda
	dodir /usr/coda/spool

	diropts -m0700
	dodir /usr/coda/etc
	dodir /usr/coda/venus.cache
}

pkg_postinst() {
	elog "To enable the coda at boot up, please do:"
	elog "    rc-update add codasrv default"
	elog "    rc-update add venus default"
	elog
	elog "To get started, run vice-setup and venus-setup."
	elog
	elog "Alternatively you can get a default coda setup by running:"
	elog "    emerge --config =${PF}"
}

pkg_config() {
	# Set of default configuration values
	local CODA_ROOT_DIR="/var/lib/vice"
	local CODA_TEST_VOLUME="codatestvol"
	local CODA_TEST_VOLUME_MOUNTPOINT="test"
	local CODA_ADMIN_UID="6000"
	local CODA_ADMIN_NAME="codaroot"
	local CODA_STORAGE_DIR="/var/lib/vice"
	local RVM_LOG_PARTITION="rvmlogpartition.img"
	local RVM_DATA_PARTITION="rvmdatapartition.img"
	local VICE_PARTITION="vicepa"
	local UPDATE_AUTHENTICATION_TOKEN="updatetoken"
	local AUTH2_AUTHENTICATION_TOKEN="auth2token"
	local VOLUTIL_AUTHENTICATION_TOKEN="volutiltoken"

	# Do not modify after this line

	local FQDN=$(hostname --fqdn)
	local CODA_MOUNTPOINT=$(codaconfedit venus.conf mountpoint)

	# Make sure coda is not running before we start messing with its files
	if [ "x$(pidof auth2)" != "x" ]; then
		eerror "Please stop coda, coda-update and auth2 first."
		exit 1
	fi

	# Also make sure venus is not running
	if [ "x$(pidof venus)" != "x" ]; then
		eerror "Please stop venus first."
		exit 1
	fi

	# Ask for the location of (amongst other things) the vice partition
	ewarn "This default configuration of coda will require 350MB of free space"
	ewarn "for Recoverable Virtual Memory. Additional space is required for"
	ewarn "the files that you store on your coda volume."
	echo
	einfon "Please specify where coda should store this data [${CODA_STORAGE_DIR}]: "
	read new_storage_dir
	if [ "x${new_storage_dir}" != "x" ]; then
		CODA_STORAGE_DIR=${new_storage_dir}
	fi
	echo

	# Check if an existing server.conf is in the way
	conf=$(codaconfedit server.conf)
	intheway=
	if [ ${conf} != /dev/null ]; then
		intheway="${intheway} ${conf}"
	fi

	# Check if an existing vice root dir is in the way
	if [ -e ${CODA_ROOT_DIR} ]; then
		intheway="${intheway} ${CODA_ROOT_DIR}"
	fi

	# Check if an existing vice partition is in the way
	if [ -e ${CODA_STORAGE_DIR}/${VICE_PARTITION} ]; then
		intheway="${intheway} ${CODA_STORAGE_DIR}/${VICE_PARTITION}"
	fi

	if [ "x${intheway}" != "x" ]; then
		eerror "Please remove the following items manually first if you want to"
		eerror "set up a default coda configuration:"
		for item in ${intheway}; do
			eerror "\t${item}"
		done
		exit 1
	fi

	einfo "A default coda server and client configuration will be set up that consists of:"
	einfo "- a coda SCM (System Control Machine)"
	einfo "- a coda administrator '${CODA_ADMIN_NAME}' with coda uid ${CODA_ADMIN_UID} and password 'changeme'"
	einfo "- a coda root volume available at /mnt/coda/${FQDN}"
	einfo "- a test volume mounted at ${CODA_MOUNTPOINT}/${FQDN}/${CODA_TEST_VOLUME_MOUNTPOINT}"
	echo
	einfon "Are you sure you want to do this? (y/n) "
	read answer
	if [ "x${answer}" != "xy" ]; then
		exit 1
	fi
	echo

	einfo "Setting up vice (the coda server)..."
	vice-setup > /dev/null <<- EOF
	yes
	${CODA_ROOT_DIR}
	y
	${UPDATE_AUTHENTICATION_TOKEN}
	${AUTH2_AUTHENTICATION_TOKEN}
	${VOLUTIL_AUTHENTICATION_TOKEN}
	1
	${CODA_ADMIN_UID}
	${CODA_ADMIN_NAME}
	yes
	${CODA_STORAGE_DIR}/${RVM_LOG_PARTITION}
	20M
	${CODA_STORAGE_DIR}/${RVM_DATA_PARTITION}
	315M
	y
	${CODA_STORAGE_DIR}/${VICE_PARTITION}
	y
	2M
	n
	EOF

	# Start coda server
	/etc/init.d/codasrv start || exit 1

	# Workaround to increase the likelihood that the coda server finished
	# starting up. Once there is a nicer way to detect this, it should
	# probably be added to the codasrv init script.
	# See http://www.coda.cs.cmu.edu/maillists/codalist/codalist-2004/6954.html
	sleep 5

	einfo "Creating root volume..."
	# Create root volume
	createvoloutput=`createvol_rep / ${FQDN} 2>&1 <<- EOF
	n
	EOF`
	if ! volutil info / &> /dev/null
	then
		eerror "Unable to create root volume, output of createvol_rep follows"
		echo "$createvoloutput"
		exit 1
	fi

	einfo "Creating test volume..."
	# Create test volume
	createvoloutput=`createvol_rep ${CODA_TEST_VOLUME} ${FQDN} 2>&1 <<- EOF
	n
	EOF`
	if ! volutil info ${CODA_TEST_VOLUME} &> /dev/null; then
		eerror "Unable to create writable volume, output of createvol_rep follows"
		echo "$createvoloutput"
		exit 1
	fi

	einfo "Setting up venus (the coda client)..."
	venus-setup ${FQDN} 20000 > /dev/null

	/etc/init.d/venus start

	einfo "Mounting test volume at ${CODA_MOUNTPOINT}/${FQDN}/${CODA_TEST_VOLUME_MOUNTPOINT}"
	clog ${CODA_ADMIN_NAME}@${FQDN} > /dev/null <<- EOF
	changeme
	EOF

	cfs mkmount ${CODA_MOUNTPOINT}/${FQDN}/${CODA_TEST_VOLUME_MOUNTPOINT} ${CODA_TEST_VOLUME}

	echo
	einfo "The coda server and client have been set up successfully."
	einfo "Please refer to http://www.coda.cs.cmu.edu/doc/html/ for Coda documentation."
	echo
	einfo "Tip: use pdbtool to add a normal coda user and clog to authenticate and get write access."
}
