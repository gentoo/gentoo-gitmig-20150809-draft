# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba/samba-3.0.5.ebuild,v 1.4 2004/07/28 05:04:37 kumba Exp $

inherit eutils

IUSE="kerberos mysql postgres xml xml2 acl cups ldap pam readline python doc"
IUSE="${IUSE} oav"

DESCRIPTION="SAMBA is a suite of SMB and CIFS client/server programs for UNIX"
HOMEPAGE="http://www.samba.org/
	http://www.openantivirus.org/projects.php
	http://samba.idealx.org"

SMBLDAP_TOOLS_VER=0.8.4
VSCAN_VER=0.3.5
VSCAN_MODS="oav sophos fprotd fsav trend icap mksd kavp clamav nai"

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
	ldap? net-nds/openldap
	pam? sys-libs/pam
	python? dev-lang/python"
DEPEND="sys-devel/autoconf
	>=sys-apps/sed-4
	${_COMMON_DEPS}"
#IDEALX scripts are now using Net::LDAP
RDEPEND="ldap? dev-perl/perl-ldap ${_COMMON_DEPS}"

KEYWORDS="x86 ~ppc sparc mips hppa amd64 ~ia64 alpha ppc64"
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	local i
	unpack ${A} || die
	cd ${S} || die

	# Clean up CVS
	find . -name .cvsignore | xargs rm -f
	find . -name CVS | xargs rm -rf

	# Add patch(es)
	# This patchset fixes Samba bugs #1315, #1319 and #1345
	# courtesy of Gerald Carter (jerry@samba.org)
	epatch ${FILESDIR}/samba-3.0.4.patch

	#Next one is from eger@cc.gatech.edu :)
	epatch ${FILESDIR}/samba-3.0.4-python-setup.patch || die
	#Fix for bug #27858
	if [ "${ARCH}" = "sparc" -o "${ARCH}" = "ppc" ]
	then
		cd ${S}/source/include
		epatch ${FILESDIR}/samba-2.2.8-statfs.patch
	fi
	#Bug #36200; sys-kernel/linux-headers dependent
	sed -i -e 's:#define LINUX_QUOTAS_2:#define LINUX_QUOTAS_1:' \
		-e 's:<linux/quota.h>:<sys/quota.h>:' \
		${S}/source/smbd/quotas.c

	# For clean docs packaging sake.
	rm -rf ${S}/examples.bin
	cp -a ${S}/examples ${S}/examples.bin

	# Prep samba-vscan source.
	use oav && cp -a ${WORKDIR}/${PN}-vscan-${VSCAN_VER} ${S}/examples.bin/VFS

	cd ${S}/source
	echo "Running autoconf ..."
	autoconf || die
}

src_compile() {
	local i
	local myconf
	local mymods

	#this is deprecated...
	#mymods="nisplussam"
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

	if [ "${ARCH}" != "amd64" ]
	then
		use kerberos && use ldap \
			&& myconf="${myconf} --with-ads" \
			|| myconf="${myconf} --without-ads"
	else
		myconf="${myconf} --without-ads"
	fi

	use python \
		&& myconf="${myconf} --with-python=yes" \
		|| myconf="${myconf} --with-python=no"

	use readline \
		&& myconf="${myconf} --with-readline" \
		|| myconf="${myconf} --without-readline"

	einfo "\$myconf is: $myconf"

	#default_{static,shared}_modules|source/configure
	#/usr/lib/samba/auth/.............      AUTH_MODULES
	#/usr/lib/samba/charset/		CHARSET_MODULES
	#/usr/lib/samba/pdb/..............      PDB_MODULES
	#/usr/lib/samba/rpc/		    RPC_MODULES
	#/usr/lib/samba/vfs/..............      VFS_MODULES|source/Makefile
	#/usr/lib/samba/lowcase.dat
	#/usr/lib/samba/upcase.dat
	#/usr/lib/samba/valid.dat

	cd source
	./configure \
		--prefix=/usr \
		--libdir=/usr/lib \
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

	# Show install dirs
	einfo "Dir conf:"
	make showlayout

	# Subshell make: some headers are to be compiled in sequence even for a 
	# parallel make
	make proto

	# Compile main SAMBA pieces.
	make everything || die "SAMBA pieces"
	make rpctorture || ewarn "rpctorture didnt build"

	# Build mount.cifs
	cd ${S}/source
	gcc ${CFLAGS} client/mount.cifs.c -o bin/mount.cifs
	assert "mount.cifs compile problem"
	# build smbget
	make bin/smbget; assert "smbget compile error"

	# Build selected samba-vscan plugins.
	if use oav
	then
		cd ${S}/examples.bin/VFS/${PN}-vscan-${VSCAN_VER}
		./configure
		assert "bad ${PN}-vscan-${VSCAN_VER} ./configure"
		# Do not use the Makefiles in the sub directories, use the Makefile
		# generated by .configure in the top-level samba-vscan directory
		# - suggested by Rainer Link, samba-vscan maintainer
		make ${VSCAN_MODS}
	fi

	# Build mkntpasswd from the smbldap-tools.
	if use ldap
	then
		cd ${WORKDIR}/smbldap-tools-${SMBLDAP_TOOLS_VER}
		tar --no-same-owner -zxf mkntpwd.tar.gz
		cd mkntpwd
		VISUAL="" make || die "mkntpwd compile problem"
	fi
}

src_install() {
	local extra_bins="debug2html smbfilter talloctort mount.cifs smbget"
	#smbsh editreg
	extra_bins="${extra_bins} smbtorture msgtest masktest locktest \
		locktest2 nsstest vfstest rpctorture"

	cd ${S}/source
	make DESTDIR=${D} install-everything

	# Extra binary files, testing/torture progs
	exeinto /usr/bin
	for i in ${extra_bins}
	do
		[ -x ${S}/source/bin/${i} ] && doexe ${S}/source/bin/${i} && \
		einfo "Extra binaries: ${i}"
	done
	# Installing these setuid-root allows users to (un)mount smbfs/cifs.
	for i in /usr/bin/smbumount /usr/bin/smbmnt /usr/bin/mount.cifs
	do
		fperms 4111 ${i}
		einfo "suid: ${i}"
	done
	# Nsswitch extensions. Make link for wins and winbind resolvers.
	exeinto /lib
	for i in wins winbind
	do
		doexe ${S}/source/nsswitch/libnss_${i}.so
		( cd ${D}/lib; ln -s libnss_${i}.so libnss_${i}.so.2 )
	done
	exeinto /lib/security
	doexe ${S}/source/nsswitch/pam_winbind.so
	use pam && doexe ${S}/source/bin/pam_smbpass.so

	# Links
	# link /usr/bin/smbmount to /sbin/mount.smbfs which allows it
	# to work transparently with the standard 'mount' command..
	dodir /sbin
	dosym /usr/bin/smbmount /sbin/mount.smbfs
	dosym /usr/bin/mount.cifs /sbin/mount.cifs
	# make the smb backend symlink for cups printing support..
	if use cups; then
		dodir /usr/lib/cups/backend
		dosym /usr/bin/smbspool /usr/lib/cups/backend/smb
	fi

	# Install IDEALX scripts for LDAP backend administration.
	if use ldap; then
		# corrections as per bug #41796
		cd ${WORKDIR}/smbldap-tools-${SMBLDAP_TOOLS_VER}
		exeinto /usr/share/samba/scripts ; doexe smbldap-*
		exeinto /usr/sbin ; doexe mkntpwd/mkntpwd
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
	fi

	# VFS plugin modules
	if use oav
	then
		exeinto /usr/lib/vfs
		doexe ${S}/examples.bin/VFS/${PN}-vscan-${VSCAN_VER}/vscan-*.so
	fi

	# Python extensions.
	if use python
	then
		cd ${S}/source
		python python/setup.py install --root=${D} || die
	fi

	# General config files.
	insinto /etc
	insinto /etc/samba
	doins ${FILESDIR}/smbusers
	newins ${FILESDIR}/smb.conf.example-samba3 smb.conf.example
	doins ${FILESDIR}/lmhosts
	doins ${FILESDIR}/recycle.conf
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

	# Docs
	docinto ""
	dodoc ${S}/COPYING ${S}/Manifest ${S}/README ${S}/Roadmap ${S}/WHATSNEW.txt
	docinto examples
	dodoc ${FILESDIR}/nsswitch.conf-{wins,winbind}
	cp -a ${S}/examples/* ${D}/usr/share/doc/${PF}/examples
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

	# moving manpages
	mv ${D}/usr/man ${D}/usr/share/man
}

pkg_postinst() {
	# touch /etc/samba/smb.conf so that people installing samba just
	# to mount smb shares don't get annoying warnings all the time..
	[ ! -e ${ROOT}/etc/samba/smb.conf ] && touch ${ROOT}/etc/samba/smb.conf

	# empty dirs..
	install -m0700 -o root -g root -d ${ROOT}/etc/samba/private
	install -m1777 -o root -g root -d ${ROOT}/var/spool/samba
	install -m0755 -o root -g root -d ${ROOT}/var/log/samba
	install -m0755 -o root -g root -d ${ROOT}/var/log/samba3
	install -m0755 -o root -g root -d ${ROOT}/var/run/samba
	install -m0755 -o root -g root -d ${ROOT}/var/cache/samba
	install -m0755 -o root -g root -d ${ROOT}/var/lib/samba/{netlogon,profiles}
	install -m0755 -o root -g root -d \
		${ROOT}/var/lib/samba/printers/{W32X86,WIN40,W32ALPHA,W32MIPS,W32PPC}

	ewarn ""
	ewarn "If you are upgrading from a Samba version prior to 3.0.2, and you"
	ewarn "use Samba's password database, you must run the following command:"
	ewarn ""
	ewarn "  pdbedit --force-initialized-passwords"
	ewarn ""
	if use ldap; then
		ewarn "If you are upgrading from prior to 3.0.2, and you are using LDAP"
		ewarn "for Samba authentication, you must check the sambaPwdLastSet"
		ewarn "attribute on all accounts, and ensure it is not 0."
		einfo ""
		einfo "WARNING: the smbldap-tools conf file location has changed to"
		einfo " /etc/smbldap-tools"
		einfo "reconfiguration will be necessary."
		einfo ""
		einfo "WARNING: the names of the scripts in /usr/shared/samba/scripts"
		einfo "have changed. Please update your /etc/samba/smb.conf."
		einfo ""
	fi
}
