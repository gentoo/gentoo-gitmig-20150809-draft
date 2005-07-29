# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/openafs/openafs-1.3.85.ebuild,v 1.4 2005/07/29 10:03:24 dholm Exp $

inherit flag-o-matic eutils toolchain-funcs versionator

PATCHVER=0.1
DESCRIPTION="The OpenAFS distributed file system"
HOMEPAGE="http://www.openafs.org/"
SRC_URI="http://openafs.org/dl/${PN}/${PV}/${P}-src.tar.bz2
	mirror://gentoo/${PN}-gentoo-${PATCHVER}.tar.bz2
	http://dev.gentoo.org/~seemant/distfiles/${PN}-gentoo-${PATCHVER}.tar.bz2"

LICENSE="IPL-1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="debug kerberos pam"

RDEPEND="=net-fs/openafs-kernel-${PV}
	pam? ( sys-libs/pam )
	kerberos? ( virtual/krb5 )"

PATCHDIR=${WORKDIR}/gentoo/patches/$(get_version_component_range 1-2)
CONFDIR=${WORKDIR}/gentoo/configs

pkg_setup() {
	if use kerberos; then
		ewarn "kerberos enabled: This is untested!"
	fi
}

src_unpack() {
	unpack ${A} ; cd ${S}

	# Apply patches to apply chosen compiler settings, fix the hardcoded paths
	# to be more FHS friendly, and the fix the incorrect typecasts for va_arg
	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}
}

src_compile() {
	# cannot use "use_with" macro, as --without-krb5-config crashes the econf
	local myconf=""
	if use kerberos; then
		myconf="--with-krb5-conf=$(type -p krb5-config)"
	fi

	econf \
		$(use_enable pam) \
		$(use_enable debug) \
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
	mv ${D}/usr/bin/kpasswd ${D}/usr/bin/kpasswd_afs

	# install manuals
	doman src/man/*.?

	use kerberos && doman src/aklog/aklog.1
	use pam && doman src/pam/pam_afs.5

	# documentation
	dodoc ${CONFDIR}/README ${CONFDIR}/CellServDB ${CONFDIR}/ChangeLog*

	# Gentoo related scripts
	newconfd ${CONFDIR}/afsconfd afs
	newinitd ${CONFDIR}/afsinitd afs
}

pkg_preinst() {
	# conventions:
	# only automatically migrate if the destination directories are
	# as of yet non-existant

	# path translations
	oldafsconfdir=${ROOT}usr/afs/etc
	newafsconfdir=${ROOT}etc/openafs/server
	oldviceetcdir=${ROOT}usr/vice/etc
	newviceetcdir=${ROOT}etc/openafs
	oldafsdbdir=${ROOT}usr/afs/db
	newafsdbdir=${ROOT}var/lib/openafs/db
	oldafslocaldir=${ROOT}usr/afs/local
	newafslocaldir=${ROOT}var/lib/openafs

	# detect Transarc afsconfdir
	afsconfdir=0
	[ ! -L ${oldafsconfdir} -a -d ${oldafsconfdir} -a ! -e ${newafsconfdir} ] && afsconfdir=1

	# detect Transarc viceetcdir
	viceetcdir=0
	viceetcsoftlink=0
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

	# detect Transarc afsdbdir
	afsdbdir=0
	[ ! -L ${oldafsdbdir} -a -d ${oldafsdbdir} -a ! -e ${newafsdbdir} ] && afsdbdir=1

	# detect Transarc afslocaldir
	afslocaldir=0
	[ ! -L ${oldafslocaldir} -a -d ${oldafslocaldir} -a ! -e ${newafslocaldir} ] && afslocaldir=1

	# detect Transarc afsbosconfigdir
	afsbosconfigdir=0
	[ ${afslocaldir} = 1 -a -f ${ROOT}usr/afs/local/BosConfig ] && afsbosconfigdir=1

	# any of these?
	any=$((${afsconfdir}+${viceetcdir}+${afsdbdir}+${afslocaldir}))

	# No migration needed?  Then bail out
	if [ $any = 0 ]; then
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
			ewarn "configuration files to new	FHS-conforming locations."
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

	# afsdbdir: migrate /usr/afs/db to /var/lib/openafs/db
	if [ ${afsdbdir} = 1 ]; then
		mkdir -m 755 -p ${newafsdbdir}
		cp ${oldafsdbdir}/* $newafsdbdir}
	fi

	# afslocaldir: migrate /usr/afs/local to /var/lib/openafs
	if [ ${afslocaldir} = 1 ]; then
		mkdir -m 755 -p ${newafslocaldir}
		cp ${oldafslocaldir}/* ${newafslocaldir}

		# afsbosconfigdir: migrate /usr/afs/local/BosConfig to /etc/openafs/BosConfig
		if [ ${afsbosconfigdir} = 1 ]; then
			sed -i \
				-e 's:/usr/afs/bin/:/usr/libexec/openafs/:g' \
				-e 's:/usr/afs/etc:/etc/openafs:g' \
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

	ewarn "Migration finished"
	ewarn "Please remember to manually migrate disk-cache (if present)"
	ewarn "Alter /etc/openafs/cacheinfo to do so"
	ebeep 5
}

pkg_postinst() {
	# See bug 9849
	# Create afs mountpoint
	mkdir /afs 2>/dev/null

	einfo
	einfo "For browsing global Cells, please get CellServDB from"
	einfo "/usr/share/doc/${PF} and put in /etc/openafs.  Then start"
	einfo "using /etc/init.d/afs right away."
	einfo "For more functionality, look at the limited README in the"
	einfo "same directory, or turn to the more elaborate procedures"
	einfo "described on http://www.openafs.org (quick beginnings)"
	einfo "After initial server setup, you can edit /etc/conf.d/afs"
	einfo "to enable the BOS Server."
	einfo ""
	einfo "To use AFS fully, you need either to start:"
	einfo "1. kaserver, which is included with openafs but as it is"
	einfo "based on kerberos4, it is not recommended."
	einfo "2. app-crypt/kth-krb, but as it is also based on kerberos4 protocol,"
	einfo "   you can keep passwords replicated in contrast to kaserver, but still"
	einfo "   don't waste your time here."
	einfo "3. app-crypt/heimdal, which is kerberos5 distribution written in Europe,"
	einfo "   so no US export restrictions apply (*recommended*, compatible with"
	einfo "   MIT krb5, see below)."
	einfo "   BTW: if you need kerberos4 backwards compatibility,"
	einfo "   heimdal can be compiled with --with-krb4 switch to provide it, but"
	einfo "   app-crypt/kth-krb must be installed so that heimdal's configure"
	einfo "   can find it. Beware that krb4 approach is not considered"
	einfo "   safe anymore, so do not install kth-krb unless you really need it."
	einfo "4. app-crypt/mit-krb5, if export restrictions allow you to do so."
	einfo
	epause 20
	ebeep 5
}

pkg_prerm() {
	# See bug 9849
	# Remove afs mountpoint
	rmdir /afs 2>/dev/null
}

