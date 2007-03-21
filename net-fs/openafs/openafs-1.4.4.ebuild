# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/openafs/openafs-1.4.4.ebuild,v 1.1 2007/03/21 10:14:09 stefaan Exp $

inherit flag-o-matic eutils linux-mod toolchain-funcs versionator

PATCHVER=0.13
DESCRIPTION="The OpenAFS distributed file system"
HOMEPAGE="http://www.openafs.org/"
SRC_URI="http://openafs.org/dl/${PN}/${PV}/${P}-src.tar.bz2
	doc? ( http://openafs.org/dl/${PN}/${PV}/${P}-doc.tar.bz2 )
	mirror://gentoo/${PN}-gentoo-${PATCHVER}.tar.bz2"

LICENSE="IBM openafs-krb5 openafs-krb5-a APSL-2 sun-rpc"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug kerberos pam doc"

RDEPEND="~net-fs/openafs-kernel-${PV}
	pam? ( sys-libs/pam )
	kerberos? ( virtual/krb5 )"

PATCHDIR=${WORKDIR}/gentoo/patches/$(get_version_component_range 1-2)
CONFDIR=${WORKDIR}/gentoo/configs
SCRIPTDIR=${WORKDIR}/gentoo/scripts

src_unpack() {
	unpack ${A}; cd ${S}

	# Apply patches to apply chosen compiler settings, fix the hardcoded paths
	# to be more FHS friendly, and the fix the incorrect typecasts for va_arg
	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}

	sed -i 's/^[ \t]*XCFLAGS.*//' src/cf/osconf.m4

	./regen.sh || die "Failed: regenerating configure script"
}

src_compile() {
	# cannot use "use_with" macro, as --without-krb5-config crashes the econf
	local myconf=""
	if use kerberos; then
		myconf="--with-krb5-conf=$(type -p krb5-config)"
	fi

	ARCH="$(tc-arch-kernel)" \
	XCFLAGS="${CFLAGS}" \
	econf \
		$(use_enable pam) \
		$(use_enable debug) \
		--enable-largefile-fileserver \
		--enable-supergroups \
		--with-linux-kernel-headers=${KV_DIR} \
		${myconf} || die econf

	emake -j1 all_nolibafs || die "Build failed"
}

src_install() {
	make DESTDIR=${D} install_nolibafs || die "Installing failed"

	# pam_afs and pam_afs.krb have been installed in irregular locations, fix
	if use pam; then
		dodir /$(get_libdir)/security
		mv ${D}/usr/$(get_libdir)/pam_afs* ${D}/$(get_libdir)/security
	fi

	# compile_et collides with com_err.  Remove it from this package.
	rm ${D}/usr/bin/compile_et

	# avoid collision with mit_krb5's version of kpasswd
	(cd ${D}/usr/bin; mv kpasswd kpasswd_afs)
	use doc && (cd doc/man-pages/man1; mv kpasswd.1 kpasswd_afs.1)

	# minimal documentation
	dodoc ${CONFDIR}/README ${CONFDIR}/CellServDB

	# documentation package
	if use doc; then
		# install manuals
		doman doc/man-pages/man?/*.?

		use pam && doman src/pam/pam_afs.5

		cp -pPR doc/* ${D}/usr/share/doc/${PF}
	fi

	# Gentoo related scripts
	newconfd ${CONFDIR}/openafs-client openafs-client
	newconfd ${CONFDIR}/openafs-server openafs-server
	newinitd ${SCRIPTDIR}/openafs-client openafs-client
	newinitd ${SCRIPTDIR}/openafs-server openafs-server

	# used directories: client
	keepdir /etc/openafs
	keepdir /var/cache/openafs

	# used directories: server
	keepdir /etc/openafs/server
	diropts -m0700
	keepdir /var/lib/openafs
	keepdir /var/lib/openafs/db
	diropts -m0755
	keepdir /var/lib/openafs/logs

	# link logfiles to /var/log
	dosym ../lib/openafs/logs /var/log/openafs
}

migrate_to_fhs() {
	# conventions:
	# only automatically migrate if the destination directories are
	# as of yet non-existant

	# path translations
	local oldafsconfdir=${ROOT}usr/afs/etc
	local newafsconfdir=${ROOT}etc/openafs/server
	local oldviceetcdir=${ROOT}usr/vice/etc
	local newviceetcdir=${ROOT}etc/openafs
	local oldafslocaldir=${ROOT}usr/afs/local
	local newafslocaldir=${ROOT}var/lib/openafs
	local oldafsdbdir=${ROOT}usr/afs/db
	local newafsdbdir=${ROOT}var/lib/openafs/db

	# detect Transarc afsconfdir
	local afsconfdir=0
	[ ! -L ${oldafsconfdir} -a -d ${oldafsconfdir} -a ! -e ${newafsconfdir} ] && afsconfdir=1

	# detect Transarc viceetcdir
	local viceetcdir=0
	local viceetcsoftlink=0
	if [ -d ${oldviceetcdir} -a ! -e ${newviceetcdir} ]; then
		if [ ! -L ${oldviceetcdir} ]; then
			viceetcdir=1
		else
			if [ $(readlink ${oldviceetcdir}) = /etc/afs ]; then
				viceetcdir=1
				viceetcsoftlink=1
			fi
		fi
	fi

	# detect Transarc afslocaldir
	local afslocaldir=0
	[ ! -L ${oldafslocaldir} -a -d ${oldafslocaldir} -a ! -e ${newafslocaldir} ] && afslocaldir=1

	# detect Transarc afsdbdir
	local afsdbdir=0
	[ ! -L ${oldafsdbdir} -a -d ${oldafsdbdir} -a ! -e ${newafsdbdir} ] && afsdbdir=1

	# detect Transarc afsbosconfigdir
	local afsbosconfigdir=0
	[ ${afslocaldir} = 1 -a -f ${oldafslocaldir}/BosConfig ] && afsbosconfigdir=1

	# any of these?
	local any=$((${afsconfdir}+${viceetcdir}+${afsdbdir}+${afslocaldir}))

	# No migration needed?  Then bail out
	if [ ${any} = 0 ]; then
		return 0
	fi

	# Root not / ?  Then do not attempt automatic migration
	if [ "$ROOT" != "/" ]; then
		ewarn Old-style configuration files found, but not migrating
		ewarn because installation rootdir is not /
		ebeep 5
		return 0
	fi

	# detect whether an installation with old config files is running
	local pid
	if pid=$(pgrep -n -U 0 bosserver) &>/dev/null; then
		# find location of executable
		if ! executable=$(readlink /proc/${pid}/exe); then
			die "Couldn't execute readlink on bosserver process"
		fi
		# if executable is not located in /usr/sbin, assume Transarc locations
		if [[ $executable != ${ROOT}usr/sbin/* ]]; then
			ewarn "Found a running process with the name \"bosserver\" and pid ${pid}"
			ewarn "that is not located in /usr/sbin.  This suggests a running"
			ewarn "OpenAFS-server with traditional TransARC path conventions."
			ewarn "This installation procedure aims to migrate old"
			ewarn "configuration files to new FHS-conform locations."
			ewarn "Please stop the running server and reattempt the upgrade"
			die "Installation aborted because of running OpenAFS server"
		fi
	fi

	# warn about migration
	ewarn
	ewarn "OpenAFS configuration/data-files have been found in old"
	ewarn "TransARC-style locations, for which the standard FHS equivalents"
	ewarn "do not exist yet.  "
	ewarn "Following procedure will copy those files to the new locations such"
	ewarn "that, given a previously working configuration, both server"
	ewarn "and client should restart without problems.  Files will be copied"
	ewarn "only, and not removed from the old locations.  For assistance"
	ewarn "in removing the old files, consult the section on Upgrading in"
	ewarn "the Gentoo OpenAFS documentation"
	ewarn "(see http://www.gentoo.org/doc/en/openafs.xml)"
	ewarn "Will continue in 30 seconds, press Ctrl-C to abort"
	ewarn
	ebeep 10
	epause 20

	# fortunately, there's no overlap between the old locations and the new ones

	# afsconfdir: migrate /usr/afs/etc to /etc/openafs/server
	if [ ${afsconfdir} = 1 ]; then
		mkdir -m 755 -p ${newafsconfdir}
		cp ${oldafsconfdir}/* ${newafsconfdir}
	fi

	# viceetcdir: migrate /usr/vice/etc (likely a link to /etc/afs) to /etc/openafs
	if [ ${viceetcdir} = 1 ]; then
		mkdir -m 755 -p ${newviceetcdir}
		cp ${oldviceetcdir}/* ${newviceetcdir}
	fi

	# afslocaldir: migrate /usr/afs/local to /var/lib/openafs
	if [ ${afslocaldir} = 1 ]; then
		mkdir -m 700 -p ${newafslocaldir}
		cp ${oldafslocaldir}/* ${newafslocaldir}

		# afsbosconfigdir: migrate /usr/afs/local/BosConfig to /etc/openafs/BosConfig
		if [ ${afsbosconfigdir} = 1 ]; then
			sed -i \
				-e 's:/usr/afs/bin/:/usr/libexec/openafs/:g' \
				-e 's:/usr/afs/etc:/etc/openafs/server:g' \
				-e 's:/usr/afs/bin:/usr/bin:g' \
				${newafslocaldir}/BosConfig
			if [ -d ${newviceetcdir} ]; then
				mv ${newafslocaldir}/BosConfig ${newviceetcdir}
			else
				ewarn
				ewarn "No ${newviceetcdir} found, couldn't move BosConfig there,"
				ewarn "it will remain in ${newafslocaldir}.  Please investigate"
				ewarn "before attempting to start the server"
				ewarn
				ebeep 3
			fi
		fi
	fi

	# afsdbdir: migrate /usr/afs/db to /var/lib/openafs/db
	if [ ${afsdbdir} = 1 ]; then
		mkdir -m 700 -p ${newafsdbdir}
		cp ${oldafsdbdir}/* ${newafsdbdir}
	fi

	ewarn "Migration finished"
	ewarn "Please remember to manually migrate disk-cache (if present)"
	ewarn "Alter /etc/openafs/cacheinfo to do so"
	ebeep 5
}

migrate_configfile() {
	local oldconfigfile=${ROOT}etc/conf.d/afs
	local oldconfigfile2=${ROOT}etc/conf.d/afs-client
	local newconfigfile=${ROOT}etc/conf.d/openafs-client

	if [ -f ${oldconfigfile} -a ! -e ${newconfigfile} ]; then
		cp ${oldconfigfile} ${newconfigfile}
	elif [ -f ${oldconfigfile2} -a ! -e ${newconfigfile} ]; then
		cp ${oldconfigfile2} ${newconfigfile}
	fi

	oldconfigfile=${ROOT}etc/conf.d/afs-server
	newconfigfile=${ROOT}etc/conf.d/openafs-server
	if [ -f ${oldconfigfile} -a ! -e ${newconfigfile} ]; then
		cp ${oldconfigfile} ${newconfigfile}
	fi
}

pkg_preinst() {
	migrate_to_fhs
	migrate_configfile

	## Somewhat intelligently install default configuration files
	## (when they are not present)
	# CellServDB
	if [ ! -e ${ROOT}etc/openafs/CellServDB ] \
		|| grep "GCO Public CellServDB" ${ROOT}etc/openafs/CellServDB &> /dev/null
	then
		cp ${CONFDIR}/CellServDB ${D}etc/openafs
	fi
	# cacheinfo: use a default location cache, 200 megabyte in size
	# (should be safe for about any root partition, the user can increase
	# the size as required)
	if [ ! -e ${ROOT}etc/openafs/cacheinfo ]; then
		echo "/afs:/var/cache/openafs:200000" > ${D}etc/openafs/cacheinfo
	fi
	# ThisCell: default to "openafs.org"
	if [ ! -e ${ROOT}etc/openafs/ThisCell ]; then
		echo "openafs.org" > ${D}etc/openafs/ThisCell
	fi
}

pkg_postinst() {
	einfo ""
	einfo "This installation should work out of the box (at least the"
	einfo "client part doing global afs-cell browsing, unless you had"
	einfo "a previous and different configuration).  If you want to"
	einfo "set up your own cell or modify the standard config,"
	einfo "please have a look at the Gentoo OpenAFS documentation"
	einfo "(warning: it is not yet up to date wrt the new file locations)"
	einfo ""
	einfo "The documentation can be found at:"
	einfo "  http://www.gentoo.org/doc/en/openafs.xml"

	epause 5
}

