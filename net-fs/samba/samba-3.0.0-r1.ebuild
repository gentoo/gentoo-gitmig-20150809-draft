# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba/samba-3.0.0-r1.ebuild,v 1.9 2004/03/23 15:11:15 avenj Exp $

inherit eutils

IUSE="kerberos mysql xml acl cups ldap pam readline python"
IUSE="${IUSE} oav"

DESCRIPTION="SAMBA is a suite of SMB and CIFS client/server programs for UNIX"
HOMEPAGE="http://www.samba.org/
	http://www.openantivirus.org/projects.php"

SMBLDAP_TOOLS_VER=0.8.1
VSCAN_VER=0.3.4
VSCAN_MODS=${VSCAN_MODS:=fprot mks openantivirus sophos trend icap clamav} #kapersky
# To build the "kapersky" plugin, the kapersky lib must be installed.

_CVS="-${PV/_/}"
S=${WORKDIR}/${PN}${_CVS}

SRC_URI="mirror://samba/${PN}${_CVS}.tar.bz2
	oav? mirror://sourceforge/openantivirus/${PN}-vscan-${VSCAN_VER}.tar.bz2
	ldap? http://samba.idealx.org/dist/smbldap-tools-${SMBLDAP_TOOLS_VER}.tgz"

_COMMON_DEPS="dev-libs/popt
	readline? sys-libs/readline
	kerberos? ( app-crypt/mit-krb5 )
	mysql? ( dev-db/mysql sys-libs/zlib )
	acl? sys-apps/acl
	cups? net-print/cups
	ldap? net-nds/openldap
	pam? sys-libs/pam
	python? dev-lang/python"
DEPEND="sys-devel/autoconf ${_COMMON_DEPS}"
#IDEALX scripts are now using Net::LDAP
RDEPEND="ldap? dev-perl/perl-ldap ${_COMMON_DEPS}"

KEYWORDS="~x86 ppc ~sparc ~mips hppa amd64 "
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	local i
	unpack ${A} || die
	cd ${S} || die

	# Clean up CVS
	#find . -name .cvsignore | xargs rm -f
	#find . -name CVS | xargs rm -rf

	# Add patch(es)
	#Next one is from eger@cc.gatech.edu :)
	patch -p1 <${FILESDIR}/samba-3.0.0-python-setup.patch || die
	#Fix for bug #27858
	if [ "${ARCH}" = "sparc" ]
	then
		cd ${S}/source/include
		epatch ${FILESDIR}/samba-2.2.8-statfs.patch
	fi

	# For clean docs packaging sake.
	rm -rf ${S}/examples.bin ; cp -a ${S}/examples ${S}/examples.bin

	# Prep samba-vscan source.
	if use oav; then
		cp -a ${WORKDIR}/${PN}-vscan-${VSCAN_VER} ${S}/examples.bin/VFS
	fi

	cd ${S}/source
	autoconf || die
}

src_compile() {
	local i
	local myconf
	local mymods

	#this is deprecated...
	#mymods="nisplussam"
	use xml && mymods="xml,${mymods}"
	use mysql && mymods="mysql,${mymods}"

	myconf="--with-expsam=${mymods}"

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
		use kerberos \
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
	#/usr/lib/samba/charset/                CHARSET_MODULES
	#/usr/lib/samba/pdb/..............      PDB_MODULES
	#/usr/lib/samba/rpc/                    RPC_MODULES
	#/usr/lib/samba/vfs/..............      VFS_MODULES|source/Makefile
	#/usr/lib/samba/lowcase.dat
	#/usr/lib/samba/upcase.dat
	#/usr/lib/samba/valid.dat

	cd source
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc/samba \
		--localstatedir=/var \
		--libdir=/usr/lib/samba \
		--with-privatedir=/etc/samba/private \
		--with-lockdir=/var/cache/samba \
		--with-piddir=/var/run/samba \
		--with-swatdir=/usr/share/swat \
		--with-configdir=/etc/samba \
		--with-logfilebase=/var/log/samba \
		\
		--enable-static --enable-shared \
		--with-manpages-langs=en \
		--without-spinlocks \
		--with-libsmbclient \
		--with-automount \
		--with-smbmount \
		--with-winbind \
		--with-quotas \
		--with-syslog \
		--with-idmap \
		--host=${CHOST} ${myconf} || die

	# Compile main SAMBA pieces.
	make everything || die "SAMBA pieces"
	#make rpctorture

	# Build selected samba-vscan plugins.
	if use oav; then
		cd ${S}/examples.bin/VFS/${PN}-vscan-${VSCAN_VER}
		./configure || die "bad ${PN}-vscan-${VSCAN_VER} ./configure"
		for i in ${VSCAN_MODS}
		do
			cd ${S}/examples.bin/VFS/${PN}-vscan-${VSCAN_VER}/$i
			make USE_INCLMKSDLIB=1 #needed for the mks build
			assert "problem building $i vscan module"
		done
	fi

	# Build mkntpasswd from the smbldap-tools.
	if use ldap; then
		cd ${WORKDIR}/smbldap-tools-${SMBLDAP_TOOLS_VER}
		tar --no-same-owner -zxf mkntpwd.tar.gz || die "mkntpwd unpack"
		cd mkntpwd
		VISUAL="" make || die "mkntpwd compile problem"
	fi
}

src_install() {
# For testing brokeness of make install
#	cd source
#	make DESTDIR=${D} install installmodules install_python
#	assert "It would be nice if that just worked."

	# Install standard binary files.
	for i in smbclient net smbspool testparm testprns smbstatus \
		smbcontrol smbtree tdbbackup nmblookup pdbedit \
		smbpasswd rpcclient smbcacls profiles ntlm_auth \
		smbcquotas smbmount smbmnt smbumount wbinfo \
		debug2html smbfilter talloctort #smbsh editreg
	do
		exeinto /usr/bin
		doexe source/bin/${i}
	done
	doexe source/script/{smbtar,findsmb}

	# TORTURE_PROGS / Testing stuff, if they built they will come.
	for i in smbtorture msgtest masktest locktest locktest2 \
		nsstest vfstest rpctorture
	do
		if [ -x source/bin/${i} ]
		then
			exeinto /usr/bin
			doexe source/bin/${i}
		fi
	done

	# Installing these two setuid-root allows users to (un)mount smbfs.
	fperms 4111 /usr/bin/smbumount
	fperms 4111 /usr/bin/smbmnt

	# Install server binaries.
	for i in smbd nmbd swat winbindd # wrepld
	do
		exeinto /usr/sbin
		doexe source/bin/${i}
	done

	# Libraries.
	exeinto /usr/lib
	#broken for a while now with some wacky glibc issue
	#doexe source/bin/smbwrapper.so
	doexe source/bin/libsmbclient.so
	insinto /usr/lib
	doins source/bin/libsmbclient.a
	insinto /usr/include
	doins source/include/libsmbclient.h
	exeinto /lib/security
	doexe source/nsswitch/pam_winbind.so
	use pam && doexe source/bin/pam_smbpass.so

	# Nsswitch extensions.
	for i in wins winbind
	do
		exeinto /lib
		doexe source/nsswitch/libnss_${i}.so
	done
	# make link for wins and winbind resolvers..
	( cd ${D}/lib ; ln -s libnss_wins.so libnss_wins.so.2 )
	( cd ${D}/lib ; ln -s libnss_winbind.so libnss_winbind.so.2 )

	# Python extensions.
	if use python; then
		cd source
		python python/setup.py install --root=${D} || die
		cd ..
	fi

	# VFS plugin modules.
	exeinto /usr/lib/samba/vfs
	use oav && doexe examples.bin/VFS/${PN}-vscan-${VSCAN_VER}/*/vscan-*.so
	for i in audit cap default_quota extd_audit fake_perms \
		netatalk readonly recycle
	do
		if [ -x source/bin/${i}.so ]
		then
			doexe source/bin/${i}.so
		fi
	done

	# Passdb modules.
	exeinto /usr/lib/samba/pdb
	use mysql && doexe source/bin/mysql.so
	use xml && doexe source/bin/xml.so

	# Install codepage data files.
	insinto /usr/lib/samba
	doins source/codepages/*.dat

	# Install SWAT helper files.
	for i in swat/help/*.html docs/htmldocs/*.html
	do
		insinto /usr/share/swat/help
		doins ${i}
	done
	for i in swat/images/*.gif
	do
		insinto /usr/share/swat/images
		doins ${i}
	done
	for i in swat/include/*.html
	do
		insinto /usr/share/swat/include
		doins ${i}
	done

	# Install IDEALX scripts for LDAP backend administration.
	if use ldap; then
		cd ${WORKDIR}/smbldap-tools-${SMBLDAP_TOOLS_VER}
		exeinto /usr/share/samba/scripts ; doexe smbldap-*.pl
		exeinto /usr/sbin ; doexe mkntpwd/mkntpwd
		insinto /etc/samba ; doins smbldap_conf.pm
		exeinto /etc/samba ; doexe smbldap_tools.pm
		eval `perl '-V:installarchlib'`
		dodir ${installarchlib}
		dosym /etc/samba/smbldap_conf.pm ${installarchlib}
		dosym /etc/samba/smbldap_conf.pm /usr/share/samba/scripts
		dosym /etc/samba/smbldap_tools.pm ${installarchlib}
		dosym /etc/samba/smbldap_tools.pm /usr/share/samba/scripts
		cd ${S}
	fi

	# Install man pages.
	doman docs/manpages/*

	# SAMBA has a lot of docs, so this just basically
	# installs them all!  We don't want two copies of
	# the book or manpages though, so:
	rm -rf docs/htmldocs/using_samba docs/manpages
	#
	dodoc COPYING Manifest README Roadmap WHATSNEW.txt
	docinto full_docs
	cp -a docs/* ${D}/usr/share/doc/${PF}/full_docs
	docinto examples
	dodoc ${FILESDIR}/nsswitch.conf-{wins,winbind}
	cp -a examples/* ${D}/usr/share/doc/${PF}/examples
	prepalldocs
	# and we should unzip the html docs..
	gunzip ${D}/usr/share/doc/${PF}/full_docs/faq/*
	gunzip ${D}/usr/share/doc/${PF}/full_docs/htmldocs/*
	if use oav; then
		docinto ${PN}-vscan-${VSCAN_VER}
		cd ${WORKDIR}/${PN}-vscan-${VSCAN_VER}
		dodoc AUTHORS COPYING ChangeLog FAQ INSTALL NEWS README TODO
		dodoc */*.conf
		cd ${S}
	fi
	if use ldap; then
		docinto smbldap-tools-${SMBLDAP_TOOLS_VER}
		cd ${WORKDIR}/smbldap-tools-${SMBLDAP_TOOLS_VER}
		dodoc CONTRIBUTORS COPYING ChangeLog FILES INFRA INSTALL README TODO
		cd ${S}
	fi
	chown -R root:root ${D}/usr/share/doc/${PF}

	# link /usr/bin/smbmount to /sbin/mount.smbfs which allows it
	# to work transparently with the standard 'mount' command..
	dodir /sbin
	dosym /usr/bin/smbmount /sbin/mount.smbfs

	# make the smb backend symlink for cups printing support..
	if use cups; then
		dodir /usr/lib/cups/backend
		dosym /usr/bin/smbspool /usr/lib/cups/backend/smb
	fi

	# Now the config files.
	insinto /etc
	insinto /etc/samba
	doins ${FILESDIR}/smbusers
	newins ${FILESDIR}/smb.conf.example-samba3 smb.conf.example
	doins ${FILESDIR}/lmhosts
	doins ${FILESDIR}/recycle.conf

	insinto /etc/pam.d
	newins ${FILESDIR}/samba.pam samba
	doins ${FILESDIR}/system-auth-winbind

	exeinto /etc/init.d
	newexe ${FILESDIR}/samba-init samba
	newexe ${FILESDIR}/winbind-init winbind

	insinto /etc/xinetd.d
	newins ${FILESDIR}/swat.xinetd swat

	if use ldap; then
		insinto /etc/openldap/schema
		doins examples/LDAP/samba.schema
	fi
}

pkg_postinst() {
	# touch /etc/samba/smb.conf so that people installing samba just
	# to mount smb shares don't get annoying warnings all the time..
	if [ ! -e ${ROOT}/etc/samba/smb.conf ] ; then
		touch ${ROOT}/etc/samba/smb.conf
	fi

	# empty dirs..
	install -m0700 -o root -g root -d ${ROOT}/etc/samba/private
	install -m1777 -o root -g root -d ${ROOT}/var/spool/samba
	install -m0755 -o root -g root -d ${ROOT}/var/log/samba
	install -m0755 -o root -g root -d ${ROOT}/var/run/samba
	install -m0755 -o root -g root -d ${ROOT}/var/cache/samba
	install -m0755 -o root -g root -d ${ROOT}/var/lib/samba/{netlogon,profiles}
	install -m0755 -o root -g root -d \
		${ROOT}/var/lib/samba/printers/{W32X86,WIN40,W32ALPHA,W32MIPS,W32PPC}
}
