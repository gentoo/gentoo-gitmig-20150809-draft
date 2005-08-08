# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba/samba-3.0.14a-r2.ebuild,v 1.12 2005/08/08 18:43:36 kloeri Exp $

inherit eutils versionator

IUSE_LINGUAS="ja pl"
IUSE="acl cups doc kerberos ldap mysql pam postgres python quotas readline
winbind xml xml2 libclamav oav selinux"

VSCAN_VER=0.3.6
PATCH_VER=0.3.2
MY_P=${PN}-${PV/_/}
MY_PP=${PN}-$(get_major_version)-gentoo-patches-${PATCH_VER}
S2=${WORKDIR}/${MY_P}
S=${S2}/source
PFVSCAN=${PN}-vscan-${VSCAN_VER}
DESCRIPTION="SAMBA is a suite of SMB and CIFS client/server programs for UNIX"
HOMEPAGE="http://www.samba.org/
	http://www.openantivirus.org/projects.php"
SRC_URI="mirror://samba/${MY_P}.tar.gz
	oav? ( mirror://sourceforge/openantivirus/${PFVSCAN}.tar.bz2 )
	mirror://gentoo/${MY_PP}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86"

RDEPEND="dev-libs/popt
	acl?       ( sys-apps/acl )
	cups?      ( net-print/cups )
	ldap?      ( kerberos? ( virtual/krb5 ) net-nds/openldap )
	mysql?     ( dev-db/mysql sys-libs/zlib )
	pam?       ( sys-libs/pam )
	postgres?  ( dev-db/postgresql sys-libs/zlib )
	python?    ( dev-lang/python )
	readline?  ( sys-libs/readline )
	xml?       ( dev-libs/libxml2 sys-libs/zlib )
	xml2?      ( dev-libs/libxml2 sys-libs/zlib )
	selinux? ( sec-policy/selinux-samba )"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	>=sys-apps/sed-4"

PRIVATE_DST=/var/lib/samba/private
PATCHDIR=${WORKDIR}/gentoo/patches

src_unpack() {
	unpack ${A}; cd ${S2}

	rm -rf ${S2}/examples.ORIG

	export EPATCH_SUFFIX="patch"
	epatch ${PATCHDIR}/general
	if use oav ; then
		cp -a ${WORKDIR}/${PFVSCAN} ${S2}/examples/VFS
		epatch ${PATCHDIR}/vscan
	fi
}

src_compile() {
	ebegin "Running autoconf"
		autoconf
	eend $?

	local myconf
	local mymods
	local mylangs

	if use xml || use xml2 ;
	then
		mymods="xml,${mymods}"
	fi
	use mysql && mymods="mysql,${mymods}"
	use postgres && mymods="pgsql,${mymods}"
	[ -n "${mymods}" ] && myconf="--with-expsam=${mymods}"

	mylangs="en"
	use linguas_ja && mylangs="${mylangs},ja"
	use linguas_pl && mylangs="${mylangs},pl"
	myconf="${myconf} --with-manpages-langs=${mylangs}"

	use ldap && myconf="${myconf} $(use_with kerberos ads)"

	econf \
		--with-fhs \
		--sysconfdir=/etc/samba \
		--localstatedir=/var \
		--with-configdir=/etc/samba \
		--with-libdir=/usr/$(get_libdir)/samba \
		--with-swatdir=/usr/share/doc/${PF}/swat \
		--with-piddir=/var/run/samba \
		--with-lockdir=/var/cache/samba \
		--with-logfilebase=/var/log/samba \
		--with-privatedir=${PRIVATE_DST} \
		--enable-static --enable-shared \
		--with-smbmount --with-automount \
		--with-libsmbclient \
		--without-spinlocks \
		--with-syslog \
		--with-idmap \
		--without-ldapsam \
		$(use_with acl acl-support) \
		$(use_enable cups) \
		$(use_with kerberos krb5) \
		$(use_with ldap) \
		$(use_with python) \
		$(use_with readline) \
		$(use_with winbind) \
		$(use_with pam) $(use_with pam pam_smbpass) \
		$(use_with quotas) $(use_with quotas sys-quotas) \
		${myconf} || die

	emake proto || die "SAMBA make proto error"
	emake everything || die "SAMBA make everything error"

	einfo "make rpctorture"
	emake rpctorture || ewarn "rpctorture didn't build"

	if use python ; then
		python python/setup.py build
	fi

	# Build samba-vscan plugins
	if use oav; then
		cd ${S2}/examples/VFS/${PFVSCAN}
		econf \
			--with-fhs \
			--libdir=/usr/$(get_libdir)/samba \
			$(use_with libclamav) || die "${PFVSCAN} ./configure failed"
		emake || die "Failed to make ${PFVSCAN}"
	fi

}

src_install() {
	local extra_bins="rpctorture"

	make DESTDIR=${D} install-everything || die

	# Extra rpctorture progs
	exeinto /usr/bin
	for i in ${extra_bins}; do
		[ -x ${S}/bin/${i} ] && doexe ${S}/bin/${i}
		einfo "Extra binaries: ${i}"
	done

	# remove .old stuff from /usr/bin:
	rm -f ${D}/usr/bin/*.old

	# Nsswitch extensions. Make link for wins and winbind resolvers
	dolib.so ${S}/nsswitch/libnss_wins.so
	dosym libnss_wins.so /usr/$(get_libdir)/libnss_wins.so.2
	if use winbind; then
		dolib.so ${S}/nsswitch/libnss_winbind.so
		dosym libnss_winbind.so /usr/$(get_libdir)/libnss_winbind.so.2
	fi

	if use pam; then
		exeinto /$(get_libdir)/security
		doexe ${S}/bin/pam_smbpass.so
	fi

	if use pam && use winbind; then
		exeinto /$(get_libdir)/security
		doexe ${S}/nsswitch/pam_winbind.so
	fi

	# mount backend
	dodir /sbin
	dosym ../usr/bin/smbmount /sbin/mount.smbfs
	dosym ../usr/bin/mount.cifs /sbin/mount.cifs

	# bug #46389: samba doesn't create symlink anymore
	# beaviour seems to be changed in 3.0.6, see bug #61046 
	dosym samba/libsmbclient.so /usr/$(get_libdir)/libsmbclient.so.0
	dosym samba/libsmbclient.so /usr/$(get_libdir)/libsmbclient.so

	# make the smb backend symlink for cups printing support..
	if use cups; then
		dodir /usr/$(get_libdir)/cups/backend
		dosym ../../../bin/smbspool /usr/$(get_libdir)/cups/backend/smb
	fi

	# VFS plugin modules
	if use oav; then
		cd ${S2}/examples/VFS/${PFVSCAN}
		make install DESTDIR=${D} || die "VFS: vscan error"
		insinto /etc/samba
		doins ${S2}/examples/VFS/${PFVSCAN}/openantivirus/*conf
	fi

	# Python extensions
	if use python; then
		cd ${S}
		python python/setup.py install --root=${D} || die
	fi

	# General config files
	insinto /etc/samba
	doins ${FILESDIR}/smbusers
	newins ${FILESDIR}/smb.conf.example-samba3.gz smb.conf.example.gz
	doins ${FILESDIR}/lmhosts

	newpamd ${FILESDIR}/samba.pam samba
	use winbind && doins ${FILESDIR}/system-auth-winbind
	insinto /etc/xinetd.d
	newins ${FILESDIR}/swat.xinetd swat
	newinitd ${FILESDIR}/samba-init samba
	newconfd ${FILESDIR}/samba-conf samba
	if use ldap; then
		insinto /etc/openldap/schema
		doins ${S2}/examples/LDAP/samba.schema
	fi

	# dirs
	diropts -m0700 ; keepdir ${PRIVATE_DST}
	diropts -m1777 ; keepdir /var/spool/samba

	diropts -m0755
	keepdir /var/{log,run,cache}/samba
	keepdir /var/lib/samba/{netlogon,profiles}
	keepdir /var/lib/samba/printers/{W32X86,WIN40,W32ALPHA,W32MIPS,W32PPC}

	# docs
	dodoc ${S2}/{COPYING,Manifest,README,Roadmap,WHATSNEW.txt}
	docinto examples
	dodoc ${FILESDIR}/nsswitch.conf-wins
	use winbind && dodoc ${FILESDIR}/nsswitch.conf-winbind

	cp -a ${S2}/examples/* ${D}/usr/share/doc/${PF}/examples

	chmod -R 755 `find ${D}/usr/share/doc/${PF}/examples -type d`
	chmod -R 644 `find ${D}/usr/share/doc/${PF}/examples ! -type d`

	if use oav; then
		docinto ${PFVSCAN}
		cd ${WORKDIR}/${PFVSCAN}
		dodoc AUTHORS COPYING ChangeLog FAQ INSTALL NEWS README TODO
		dodoc */*.conf
	fi
	if ! use doc; then
		rm -rf ${D}/usr/share/doc/${PF}/swat/help/{guide,howto,devel}
		rm -rf ${D}/usr/share/doc/${PF}/swat/using_samba
	fi

	# Patch ChangeLog
	docinto gentoo
	dodoc ${PATCHDIR}/ChangeLog
}

pkg_preinst() {
	local PRIVATE_SRC=/etc/samba/private
	if [[ ! -r ${ROOT}/${PRIVATE_DST}/secrets.tdb \
		&& -r ${ROOT}/${PRIVATE_SRC}/secrets.tdb ]]; then
		ebegin "Copying ${ROOT}/${PRIVATE_SRC}/* to ${ROOT}/${PRIVATE_DST}/"
			mkdir -p ${IMAGE}/${PRIVATE_DST}
			cp -af ${ROOT}/${PRIVATE_SRC}/* ${IMAGE}/${PRIVATE_DST}/
		eend $?
	fi

	if [[ ! -f "${ROOT}/etc/samba/smb.conf" ]]; then
		touch ${IMAGE}/etc/samba/smb.conf
	fi
}

pkg_postinst() {
	ewarn ""
	ewarn "If you are upgrading from a Samba version prior to 3.0.2, and you"
	ewarn "use Samba's password database, you must run the following command:"
	ewarn ""
	ewarn "  pdbedit --force-initialized-passwords"
	ewarn ""
	ewarn "2004-09: LIBs flags changes for suid bins: LDFLAGS+='-Wl,-z,now'"
	ewarn "3.0.12: libsmbclient shared library retrocompatibility is not "
	ewarn "        assured: please rebuild all samba-linked third part packages"

	if use winbind; then
		ewarn "         3.0.7: param: 'winbind enable local accounts' is now"
		ewarn "                       disabled by default"
	fi

	ewarn "2004-11: /etc/samba/private moved to ${PRIVATE_DST}"
	ewarn "            for better File System Hierarchy adeherence"
	ewarn ""
	einfo "If you experience client locks in file transfers _only_, try the parameter"
	einfo "         use sendfile = no (man smb.conf(5), man sendfile(2))"
	einfo "There also seem some problems with the smbfs implementation of the recent 2.6.x kernels"
	einfo "If you experience problems (lockups) with smbfs, try cifs as an alternative"
	einfo ""

	if use ldap; then
		ewarn "If you are upgrading from prior to 3.0.2, and you are using LDAP"
		ewarn "    for Samba authentication, you must check the sambaPwdLastSet"
		ewarn "    attribute on all accounts, and ensure it is not 0."
		einfo ""
		ewarn "2005-03 [3.0.12]: smbldap-tools is now a separate package"
		ewarn "                      for ease of upgrade"
	fi

	einfo "There is a good HOWTO about setting up samba3 with cups and clamav at"
	einfo "http://www.gentoo.org/doc/en/quick-samba-howto.xml"
}

pkg_postrm(){
	# If stale docs, and one isn't re-emerging the latest version, removes
	# (this is really a portage bug, though)
	[[ -n "${PF}" && ! -f ${ROOT}/usr/lib/${PN}/en.msg ]] && \
		rm -rf ${ROOT}/usr/share/doc/${PF}
}

