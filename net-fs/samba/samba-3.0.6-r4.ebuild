# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba/samba-3.0.6-r4.ebuild,v 1.14 2004/10/21 09:26:06 satya Exp $

inherit eutils flag-o-matic

IUSE="kerberos mysql postgres xml xml2 acl cups ldap pam readline python doc"
IUSE="${IUSE} oav selinux"

DESCRIPTION="SAMBA is a suite of SMB and CIFS client/server programs for UNIX"
HOMEPAGE="http://www.samba.org/
	http://www.openantivirus.org/projects.php
	http://samba.idealx.org"

SMBLDAP_TOOLS_VER=0.8.5
VSCAN_VER=0.3.5
# all vscan modules are being installed
#VSCAN_MODS="oav sophos fprotd fsav trend icap mksd kavp clamav nai" 

_CVS="-${PV/_/}"
S=${WORKDIR}/${PN}${_CVS}

SRC_URI="mirror://samba/${PN}${_CVS}.tar.gz
	oav? mirror://sourceforge/openantivirus/${PN}-vscan-${VSCAN_VER}.tar.bz2
	ldap? http://samba.idealx.org/dist/smbldap-tools-${SMBLDAP_TOOLS_VER}.tgz"

_COMMON_DEPS="dev-libs/popt
	readline? sys-libs/readline
	ldap? ( kerberos? ( virtual/krb5 ) )
	mysql? ( dev-db/mysql sys-libs/zlib )
	postgres? ( dev-db/postgresql sys-libs/zlib )
	xml? ( dev-libs/libxml2 sys-libs/zlib )
	xml2? ( dev-libs/libxml2 sys-libs/zlib )
	acl? sys-apps/acl
	cups? net-print/cups
	ldap? ( net-nds/openldap dev-perl/Crypt-SmbHash )
	pam? sys-libs/pam
	python? dev-lang/python"
DEPEND="sys-devel/autoconf
	>=sys-apps/sed-4
	${_COMMON_DEPS}"
#IDEALX scripts are now using Net::LDAP
#selinux: bug #62907
RDEPEND="ldap? dev-perl/perl-ldap ${_COMMON_DEPS}
	selinux? ( sec-policy/selinux-samba )"

LICENSE="GPL-2"
SLOT="0"
# some archs are removed due to dependency tree integrity for ldap and
#   dev-perl/Crypt-SmbHash flags
#   should be: KEYWORDS="~arm ~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~mips ppc sparc x86"

src_unpack() {
	local i
	unpack ${A} || die
	cd ${S} || die
	# Clean up CVS ---------------------------------------------------------
	find . -name .cvsignore | xargs rm -f
	find . -name CVS | xargs rm -rf
	# Add patch(es) --------------------------------------------------------
	# This patchset fixes Samba bugs #1315, #1319 and #1345
	# courtesy of Gerald Carter (jerry@samba.org)
	# they are hopefully fixed in this version !
	# epatch ${FILESDIR}/samba-3.0.x.patch
	#Next one is from eger@cc.gatech.edu
	epatch ${FILESDIR}/samba-3.0.x-python-setup.patch || die
	#bug #44743 ------------------------------------------------------------
	if [ ${ARCH} = "amd64" -o ${ARCH} = "ppc" -o ${ARCH} = "ppc64" ]; then
		cd ${S} && epatch ${FILESDIR}/samba-3.0.x-smbumount-uid32.patch
	fi
	#Fix for bug #27858 ----------------------------------------------------
	if [ ${ARCH} = "sparc" -o ${ARCH} = "ppc" -o ${ARCH} = "ppc64" ]; then
		cd ${S}/source/include && epatch ${FILESDIR}/samba-2.2.8-statfs.patch
	fi
	#Bug #36200; sys-kernel/linux-headers dependent ------------------------
	sed -i -e 's:#define LINUX_QUOTAS_2:#define LINUX_QUOTAS_1:' \
		-e 's:<linux/quota.h>:<sys/quota.h>:' \
		${S}/source/smbd/quotas.c
	#samba 3.0.6: bugs 61055 and 62476 -------------------------------------
	cd ${S}/source || die
	epatch ${FILESDIR}/samba-3.0.6-homes-reuse_v2.patch || die
	epatch ${FILESDIR}/samba-3.0.6-winbind_getpwnam_v1.patch || die
	cp ${FILESDIR}/samba-3.0.6-samba.schema ${S}/examples/LDAP/samba.schema
	cd ${S} || die
	use amd64 && epatch ${FILESDIR}/${P}-libdirsymlink.patch
	# examples: to be copied as docs ---------------------------------------
	rm -rf ${S}/examples.ORIG
	cp -a ${S}/examples ${S}/examples.ORIG
	# Prep samba-vscan source.
	use oav && cp -a ${WORKDIR}/${PN}-vscan-${VSCAN_VER} ${S}/examples/VFS
	#-----------------------------------------------------------------------
	cd ${S}/source
	echo "Running autoconf ..."
	autoconf || die
}

src_compile() {
	local i
	local myconf
	local mymods
	#mymods="nisplussam" #this is deprecated...
	#-----------------------------------------------------------------------
	use xml || use xml2 && mymods="xml,${mymods}"
	use mysql && mymods="mysql,${mymods}"
	use postgres && mymods="pgsql,${mymods}"
	[ -n "${mymods}" ] && myconf="--with-expsam=${mymods}"
	use acl \
		&& myconf="${myconf} --with-acl-support" \
		|| myconf="${myconf} --without-acl-support"
	use pam \
		&& myconf="${myconf} --with-pam --with-pam_smbpass" \
		|| myconf="${myconf} --without-pam --without-pam_smbpass"
	use cups \
		&& myconf="${myconf} --enable-cups" \
		|| myconf="${myconf} --disable-cups"
	use ldap \
		&& myconf="${myconf} --with-ldap" \
		|| myconf="${myconf} --without-ldap"
	#this is for old samba 2.x compat
	#myconf="${myconf} --with-ldapsam"
	myconf="${myconf} --without-ldapsam"
	use python \
		&& myconf="${myconf} --with-python=yes" \
		|| myconf="${myconf} --with-python=no"
	use readline \
		&& myconf="${myconf} --with-readline" \
		|| myconf="${myconf} --without-readline"
	#Fix #57063 ------------------------------------------------------------
	# too cautious for some archs: maybe -O2 is sufficient on some of them
	strip-flags
	if [ "${ARCH}" = "ppc" -o "${ARCH}" = "ppc64" ]; then
		replace-flags -O? -O1
	else
		replace-flags -O? -O1
	fi
	#-----------------------------------------------------------------------
	if [ "${ARCH}" != "amd64" ]; then
		use kerberos && use ldap \
			&& myconf="${myconf} --with-ads" \
			|| myconf="${myconf} --without-ads"
	else
		myconf="${myconf} --without-ads"
	fi
	#-----------------------------------------------------------------------
	# glibc preload issue
	append-ldflags -Wl,-z,now -L/usr/$(get_libdir)
	for info_var in myconf CFLAGS LDFLAGS; do
		einfo "${info_var} is: ${!info_var}"
	done
	#-----------------------------------------------------------------------
	#default_{static,shared}_modules|source/configure
	cd ${S}/source
	econf \
		--prefix=/usr \
		--libdir=/usr/lib/samba \
		--with-libdir=/usr/lib/samba \
		--with-swatdir=/usr/share/doc/${PF}/swat \
		--localstatedir=/var \
		--with-piddir=/var/run/samba \
		--with-lockdir=/var/cache/samba \
		--with-logfilebase=/var/log/samba \
		--sysconfdir=/etc/samba \
		--with-configdir=/etc/samba \
		--with-privatedir=/etc/samba/private \
		\
		--enable-static \
		--enable-shared \
		--with-manpages-langs=en \
		--without-spinlocks \
		--with-libsmbclient \
		--with-automount \
		--with-smbmount \
		--with-winbind \
		--with-quotas \
		--with-syslog \
		--with-idmap \
		--host=${CHOST} \
		${myconf} || die
	# Show install dirs ----------------------------------------------------
	einfo "Dir conf:"
	emake showlayout
	# serialized headers make ----------------------------------------------
	make proto
	# Compile main SAMBA pieces --------------------------------------------
	einfo "make everything" && emake everything || die "SAMBA make everything error"
	einfo "make rpctorture" && emake rpctorture || ewarn "rpctorture didn't build"
	# build smbget ---------------------------------------------------------
	einfo "smbget"
	emake bin/smbget; assert "smbget compile error"
	# Build selected samba-vscan plugins -----------------------------------
	if use oav; then
		cd ${S}/examples/VFS/${PN}-vscan-${VSCAN_VER}
		./configure --prefix=/usr --libdir=/usr/lib/samba
		assert "bad ${PN}-vscan-${VSCAN_VER} ./configure"
		emake #${VSCAN_MODS}
	fi
	# Build mkntpasswd from the smbldap-tools ------------------------------
	# Attention: usage of dev-perl/Crypt-SmbHash for smbldap-tool > 0.8.5
	if use ldap; then
		cd ${WORKDIR}/smbldap-tools-${SMBLDAP_TOOLS_VER}
		if [ -f mkntpwd.tar.gz ]; then
			tar --no-same-owner -zxf mkntpwd.tar.gz
			cd mkntpwd
			VISUAL="" make || die "mkntpwd compile problem"
		fi
	fi
	# suid compile ---------------------------------------------------------
	cd ${S}/source
	gcc ${CFLAGS} ${LDFLAGS} client/mount.cifs.c -o bin/mount.cifs || die "mount.cifs compile problem"
}

src_install() {
	local extra_bins="debug2html smbfilter talloctort mount.cifs smbget"
	#smbsh editreg
	extra_bins="${extra_bins} smbtorture msgtest masktest locktest \
		locktest2 nsstest vfstest rpctorture"
	# ----------------------------------------------------------------------
	cd ${S}/source
	make DESTDIR=${D} install-everything
	# Extra binary files, testing/torture progs ----------------------------
	exeinto /usr/bin
	for i in ${extra_bins}; do
		[ -x ${S}/source/bin/${i} ] && doexe ${S}/source/bin/${i} && \
		einfo "Extra binaries: ${i}"
	done
	# Installing these setuid-root allows users to (un)mount smbfs/cifs ----
	for i in /usr/bin/smbumount /usr/bin/smbmnt /usr/bin/mount.cifs; do
		fperms 4111 ${i} || die "No perms: ${i}"
		einfo "suid: ${i}"
	done
	# Nsswitch extensions. Make link for wins and winbind resolvers --------
	exeinto /lib
	for i in wins winbind; do
		doexe ${S}/source/nsswitch/libnss_${i}.so
		( cd ${D}/lib; ln -s libnss_${i}.so libnss_${i}.so.2 )
	done
	exeinto /lib/security
	doexe ${S}/source/nsswitch/pam_winbind.so
	use pam && doexe ${S}/source/bin/pam_smbpass.so
	# mount backend --------------------------------------------------------
	dodir /sbin
	dosym ../usr/bin/smbmount /sbin/mount.smbfs
	dosym ../usr/bin/mount.cifs /sbin/mount.cifs
	# bug #46389: samba doesn't create symlink anymore
	# beaviour seems to be changed in 3.0.6, see bug #61046 
	dosym /usr/lib/samba/libsmbclient.so /usr/lib/libsmbclient.so.0
	dosym /usr/lib/samba/libsmbclient.so /usr/lib/libsmbclient.so
	# make the smb backend symlink for cups printing support..
	if use cups; then
		dodir /usr/lib/cups/backend
		dosym /usr/bin/smbspool /usr/lib/cups/backend/smb
	fi
	# Install IDEALX scripts for LDAP backend administration ---------------
	if use ldap; then
		# corrections as per bug #41796
		cd ${WORKDIR}/smbldap-tools-${SMBLDAP_TOOLS_VER}
		exeinto /usr/share/samba/scripts; doexe smbldap-*
		exeinto /etc/samba ; doexe smbldap_tools.pm
		insinto /etc/smbldap-tools ; doins *.conf
		fperms 644 /etc/smbldap-tools/smbldap.conf
		fperms 600 /etc/smbldap-tools/smbldap_bind.conf
		eval `perl '-V:installarchlib'`
		dodir ${installarchlib}
		#dosym /etc/samba/smbldap_conf.pm ${installarchlib}
		#dosym /etc/samba/smbldap_conf.pm /usr/share/samba/scripts
		dosym /etc/samba/smbldap_tools.pm ${installarchlib}
		dosym /etc/samba/smbldap_tools.pm /usr/share/samba/scripts
		if [ -f mkntpwd/mkntpwd ]; then
			exeinto /usr/sbin ; doexe mkntpwd/mkntpwd
		fi
	fi
	# VFS plugin modules ---------------------------------------------------
	if use oav; then
		#exeinto /usr/lib/samba/vfs
		#doexe ${S}/examples/VFS/${PN}-vscan-${VSCAN_VER}/vscan-*.so
		cd ${S}/examples/VFS/${PN}-vscan-${VSCAN_VER}
		make install DESTDIR=${D} || die "VFS: vscan error"
		insinto /etc/samba
		doins ${S}/examples/VFS/${PN}-vscan-${VSCAN_VER}/openantivirus/*conf
	fi
	# Python extensions ----------------------------------------------------
	if use python; then
		cd ${S}/source
		python python/setup.py install --root=${D} || die
	fi
	# General config files -------------------------------------------------
	insinto /etc/samba
	touch ${D}/etc/samba/smb.conf
	doins ${FILESDIR}/smbusers
	newins ${FILESDIR}/smb.conf.example-samba3.gz smb.conf.example.gz
	doins ${FILESDIR}/lmhosts
	#doins ${FILESDIR}/recycle.conf #obsolete: see bug #68315
	insinto /etc/pam.d
	newins ${FILESDIR}/samba.pam samba
	doins ${FILESDIR}/system-auth-winbind
	insinto /etc/xinetd.d
	newins ${FILESDIR}/swat.xinetd swat
	exeinto /etc/init.d; newexe ${FILESDIR}/samba-init samba
	insinto /etc/conf.d; newins ${FILESDIR}/samba-conf samba
	if use ldap; then
		insinto /etc/openldap/schema
		doins ${S}/examples/LDAP/samba.schema
	fi
	# dirs -----------------------------------------------------------------
	diropts -m0700
	dodir /etc/samba/private
	touch ${D}/etc/samba/private/.keep
	diropts -m1777
	dodir /var/spool/samba
	touch ${D}/var/spool/samba/.keep
	diropts -m0755
	dodir /var/{log,run,cache}/samba
	dodir /var/lib/samba/{netlogon,profiles}
	dodir /var/lib/samba/printers/{W32X86,WIN40,W32ALPHA,W32MIPS,W32PPC}
	touch ${D}/var/{log,run,cache}/samba/.keep
	touch ${D}/var/lib/samba/{netlogon,profiles}/.keep
	touch ${D}/var/lib/samba/printers/{W32X86,WIN40,W32ALPHA,W32MIPS,W32PPC}/.keep
	# docs -----------------------------------------------------------------
	docinto ""
	dodoc ${S}/COPYING ${S}/Manifest ${S}/README ${S}/Roadmap ${S}/WHATSNEW.txt
	docinto examples
	dodoc ${FILESDIR}/nsswitch.conf-{wins,winbind}
	cp -a ${S}/examples.ORIG/* ${D}/usr/share/doc/${PF}/examples
	if use oav; then
		docinto ${PN}-vscan-${VSCAN_VER}
		cd ${WORKDIR}/${PN}-vscan-${VSCAN_VER}
		dodoc AUTHORS COPYING ChangeLog FAQ INSTALL NEWS README TODO
		dodoc */*.conf
	fi
	if use ldap; then
		docinto smbldap-tools-${SMBLDAP_TOOLS_VER}
		cd ${WORKDIR}/smbldap-tools-${SMBLDAP_TOOLS_VER}
		dodoc CONTRIBUTORS COPYING ChangeLog FILES INFRA INSTALL README TODO
	fi
	if ! use doc; then
		rm -rf ${D}/usr/share/doc/${PF}/swat/help/{guide,howto,devel}
		rm -rf ${D}/usr/share/doc/${PF}/swat/using_samba
	fi
	chown -R root:root ${D}/usr/share/doc/${PF}
	# moving manpages ------------------------------------------------------
	mv ${D}/usr/man ${D}/usr/share/man
}

pkg_postinst() {
	# touch /etc/samba/smb.conf so that people installing samba just
	# to mount smb shares don't get annoying warnings all the time..
	#[ ! -e ${ROOT}/etc/samba/smb.conf ] && touch ${ROOT}/etc/samba/smb.conf

	ewarn ""
	ewarn "If you are upgrading from a Samba version prior to 3.0.2, and you"
	ewarn "use Samba's password database, you must run the following command:"
	ewarn ""
	ewarn "  pdbedit --force-initialized-passwords"
	ewarn ""
	ewarn "2004-05: LIBs location change: /usr/lib/samba/*"
	ewarn "            (due to ldap/vfs external tools assumptions)"
	ewarn "2004-09: LIBs default flags changes: LDFLAGS+='-Wl,-z,now'"
	ewarn ""
	if use ldap; then
		ewarn "If you are upgrading from prior to 3.0.2, and you are using LDAP"
		ewarn "    for Samba authentication, you must check the sambaPwdLastSet"
		ewarn "    attribute on all accounts, and ensure it is not 0."
		einfo "2004-07: WARNING: smbldap-tools changes"
		einfo "         smbldap-tools conf changed to /etc/smbldap-tools"
		einfo "         /usr/shared/samba/scripts: some script names changed"
		einfo "         dev-perl/Crypt-SmbHash: new pwd hash validation/conversion system"
		einfo ""
	fi
}

