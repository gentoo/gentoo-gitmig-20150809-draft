# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/openafs/openafs-1.2.13-r2.ebuild,v 1.5 2007/07/12 05:38:40 mr_bones_ Exp $

inherit fixheadtails flag-o-matic eutils toolchain-funcs versionator

PATCHVER=0.2b
DESCRIPTION="The OpenAFS distributed file system"
HOMEPAGE="http://www.openafs.org/"
SRC_URI="http://openafs.org/dl/${PN}/${PV}/${P}-src.tar.bz2
	mirror://gentoo/${PN}-gentoo-${PATCHVER}.tar.bz2
	http://dev.gentoo.org/~stefaan/distfiles/${PN}-gentoo-${PATCHVER}.tar.bz2"

LICENSE="IPL-1"
SLOT="0"
KEYWORDS="~alpha ~x86"
IUSE="pam"

RDEPEND="=net-fs/openafs-kernel-${PV}*"

PATCHDIR=${WORKDIR}/gentoo/patches/$(get_version_component_range 1-2)
CONFDIR=${WORKDIR}/gentoo/configs
SCRIPTDIR=${WORKDIR}/gentoo/scripts

src_unpack() {
	unpack ${A}; cd ${S}

	ht_fix_file "acinclude.m4"
	ht_fix_file "config.guess"
	ht_fix_file "src/afsd/afs.rc.linux"
	ht_fix_file "aclocal.m4"
	ht_fix_file "configure"
	ht_fix_file "configure-libafs"

	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}
}

src_compile() {
	econf \
		--enable-full-vos-listvol-switch \
		|| die econf

	emake -j1 CC="$(tc-getCC) -fPIC" MT_CC="$(tc-getCC)" all_nolibafs || die "Build failed"
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
	mv ${D}/usr/bin/kpasswd ${D}/usr/bin/kpasswd_afs

	# install manuals
	doman src/man/*.?
	doman src/aklog/aklog.1
	use pam && doman src/pam/pam_afs.5

	# minimal documentation
	dodoc ${CONFDIR}/README ${CONFDIR}/ChangeLog*

	# documentation package
	if use doc; then
		cp -pPR doc/* ${D}/usr/share/doc/${P}
	fi

	# Gentoo related scripts
	newconfd ${CONFDIR}/afs-client afs-client
	newconfd ${CONFDIR}/afs-server afs-server
	newinitd ${SCRIPTDIR}/afs-client afs-client
	newinitd ${SCRIPTDIR}/afs-server afs-server

	# used directories: client
	keepdir /etc/openafs
	keepdir /var/cache/openafs

	# used directories: server
	keepdir /etc/openafs/server
	diropts -m0700
	keepdir /var/lib/openafs
	keepdir /var/lib/openafs/db
	keepdir /var/lib/openafs/logs
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
	ewarn "in removing the old files, consult the documentation in"
	ewarn "/usr/share/openafs/gentoo"
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
	local newconfigfile=${ROOT}etc/conf.d/afs-client

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
	# cacheinfo: use a default location cache, 50 megabyte in size
	# (should be safe for about any root partition, the user can increase
	# the size as required)
	if [ ! -e ${ROOT}etc/openafs/cacheinfo ]; then
		echo "/afs:/var/cache/openafs:50000" > ${D}etc/openafs/cacheinfo
	fi
	# ThisCell: default to "openafs.org"
	if [ ! -e ${ROOT}etc/openafs/ThisCell ]; then
		echo "openafs.org" > ${D}etc/openafs/ThisCell
	fi
}

pkg_postinst() {
	# See bug 9849
	# Create afs mountpoint
	mkdir /afs 2>/dev/null

	elog
	elog "For browsing global Cells, please get CellServDB from"
	elog "/usr/share/doc/${PF} and put in /etc/openafs.  Then start"
	elog "using /etc/init.d/afs right away."
	elog "For more functionality, look at the limited README in the"
	elog "same directory, or turn to the more elaborate procedures"
	elog "described on http://www.openafs.org (quick beginnings)"
	elog "After initial server setup, you can edit /etc/conf.d/afs"
	elog "to enable the BOS Server."
	elog ""
	elog "To use AFS fully, you need either to start:"
	elog "1. kaserver, which is included with openafs but as it is"
	elog "based on kerberos4, it is not recommended."
	elog "2. app-crypt/kth-krb, but as it is also based on kerberos4 protocol,"
	elog "   you can keep passwords replicated in contrast to kaserver, but still"
	elog "   don't waste your time here."
	elog "3. app-crypt/heimdal, which is kerberos5 distribution written in Europe,"
	elog "   so no US export restrictions apply (*recommended*, compatible with"
	elog "   MIT krb5, see below)."
	elog "   BTW: if you need kerberos4 backwards compatibility,"
	elog "   heimdal can be compiled with --with-krb4 switch to provide it, but"
	elog "   app-crypt/kth-krb must be installed so that heimdal's configure"
	elog "   can find it. Beware that krb4 approach is not considered"
	elog "   safe anymore, so do not install kth-krb unless you really need it."
	elog "4. app-crypt/mit-krb5, if export restrictions allow you to do so."
	elog

	epause 20
	ebeep 5
}

pkg_prerm() {
	# See bug 9849
	# Remove afs mountpoint
	rmdir /afs 2>/dev/null
}
