# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba/samba-2.2.5-r1.ebuild,v 1.1 2002/08/27 20:39:48 woodchip Exp $

DESCRIPTION="SAMBA is a suite of SMB and CIFS client/server programs for UNIX"
HOMEPAGE="http://www.samba.org"

S=${WORKDIR}/${P}
SRC_URI="http://us2.samba.org/samba/ftp/${P}.tar.gz"

RDEPEND="virtual/glibc
	>=sys-libs/pam-0.72
	acl? ( sys-apps/acl )
	cups? ( net-print/cups )
	ldap? ( =net-nds/openldap-2* )
	ssl? ( >=dev-libs/openssl-0.9.6 )"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc64"

src_unpack() {
	unpack ${A} ; cd ${S}
	patch -p0 < ${FILESDIR}/samba-2.2.2-smbmount.diff || die

	# fix kerberos include file collision..
	cd ${S}/source/include
	mv profile.h smbprofile.h
	sed -e "s:profile\.h:smbprofile.h:" includes.h > includes.h.new
	mv includes.h.new includes.h

	#cd ${S}/source
	#autoconf || die
}

src_compile() {
	local myconf
	use acl && myconf="${myconf} --with-acl-support"
	use acl ||  myconf="${myconf} --without-acl-support"
	use ssl && myconf="${myconf} --with-ssl"
	use ssl || myconf="${myconf} --without-ssl"
	use cups && myconf="${myconf} --enable-cups"
	use cups || myconf="${myconf} --disable-cups"
	use ldap && myconf="${myconf} --with-ldapsam"
	use ldap || myconf="${myconf} --without-ldapsam"

	cd ${S}/source
	./configure \
		--prefix=/usr \
		--bindir=/usr/sbin \
		--libdir=/etc/samba \
		--sbindir=/usr/sbin \
		--sysconfdir=/etc/samba \
		--localstatedir=/var/log \
		--with-configdir=/etc/samba \
		--with-mandir=/usr/share/man \
		--with-piddir=/var/run/samba \
		--with-lockdir=/var/run/samba \
		--with-swatdir=/usr/share/swat \
		--with-privatedir=/etc/samba/private \
		--with-codepagedir=/var/lib/samba/codepages \
		--with-pam --with-pam_smbpass \
		--without-sambabook \
		--without-automount \
		--without-spinlocks \
		--with-libsmbclient \
		--with-smbwrapper \
		--with-netatalk \
		--with-smbmount \
		--with-profile \
		--with-quotas \
		--with-syslog \
		--with-msdfs \
		--with-utmp \
		--with-vfs \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	make all smbfilter smbwrapper smbcacls pam_smbpass \
		nsswitch nsswitch/libnss_wins.so debug2html
	assert "compile problem"
}

src_install() {
	local i

	# we may as well do this all manually since it was starting
	# to get out of control and samba _does_ have some rather
	# silly installation quirks ;)  much of this was adapted
	# from mandrake's .spec file..
	#
	# // woodchip - 5 May 2002


	# install standard binary files..
	for i in nmblookup smbclient smbpasswd smbstatus testparm testprns \
		make_smbcodepage make_unicodemap make_printerdef rpcclient \
		smbspool smbcacls smbclient smbmount smbumount smbsh wbinfo
	do
		exeinto /usr/bin
		doexe source/bin/${i}
	done
	# make users lives easier..
	fperms 4755 /usr/bin/smbumount


	# libraries..
	exeinto /usr/lib
	doexe source/bin/smbwrapper.so
	doexe source/bin/libsmbclient.so
	insinto /usr/lib
	doins source/bin/libsmbclient.a
	exeinto /lib/security
	doexe source/bin/pam_smbpass.so
	doexe source/nsswitch/pam_winbind.so


	# some utility scripts..
	for i in mksmbpasswd.sh smbtar convert_smbpasswd
	do
		exeinto /usr/bin
		doexe source/script/${i}
	done


	# install secure binary files..
	for i in smbd nmbd swat smbfilter debug2html smbmnt smbcontrol winbindd
	do
		exeinto /usr/sbin
		doexe source/bin/${i}
	done
	# make users lives easier..
	fperms 4755 /usr/sbin/smbmnt


	# install man pages..
	doman docs/manpages/*


	# install codepage source files
	for i in 437 737 775 850 852 857 861 862 866 932 936 949 950 1125 1251
	do
		insinto /var/lib/samba/codepages/src
		doins source/codepages/codepage_def.${i}
	done
	for i in 437 737 775 850 852 857 861 862 866 932 936 949 950 1125 1251 \
		ISO8859-1 ISO8859-2 ISO8859-5 ISO8859-7 \
		ISO8859-9 ISO8859-13 ISO8859-15 KOI8-R KOI8-U
	do
		insinto /var/lib/samba/codepages/src
		doins source/codepages/CP${i}.TXT
	done


	# build codepage load files..
	for i in 437 737 775 850 852 857 861 862 866 932 936 949 950 1125 1251
	do
		${D}/usr/bin/make_smbcodepage c ${i} \
			${D}/var/lib/samba/codepages/src/codepage_def.${i} \
			${D}/var/lib/samba/codepages/codepage.${i}
	done


	# build unicode load files..
	for i in 437 737 775 850 852 857 861 862 866 932 936 949 950 1125 1251 \
		ISO8859-1 ISO8859-2 ISO8859-5 ISO8859-7 \
		ISO8859-9 ISO8859-13 ISO8859-15 KOI8-R KOI8-U
	do
		${D}/usr/bin/make_unicodemap ${i} \
			${D}/var/lib/samba/codepages/src/CP${i}.TXT \
			${D}/var/lib/samba/codepages/unicode_map.${i}
	done
	rm -rf ${D}/var/lib/samba/codepages/src


	# install the nsswitch library extension files..
	for i in wins winbind
	do
		exeinto /lib
		doexe source/nsswitch/libnss_${i}.so
	done
	# make link for wins and winbind resolvers..
	( cd ${D}/lib ; ln -s libnss_wins.so libnss_wins.so.2 )
	( cd ${D}/lib ; ln -s libnss_winbind.so libnss_winbind.so.2 )


	# install SWAT helper files..
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


	# install the O'Reilly "Using Samba" book..
	for i in docs/htmldocs/using_samba/*.html
	do
		insinto /usr/share/swat/using_samba
		doins ${i}
	done
	for i in docs/htmldocs/using_samba/gifs/*.gif
	do
		insinto /usr/share/swat/using_samba/gifs
		doins ${i}
	done
	for i in docs/htmldocs/using_samba/figs/*.gif
	do
		insinto /usr/share/swat/using_samba/figs
		doins ${i}
	done


	# too many docs to sort through; install them all! :)
	dodoc COPYING Manifest README Roadmap WHATSNEW.txt
	docinto full_docs
	cp -a docs/* ${D}/usr/share/doc/${PF}/full_docs
	# but we don't want two copies of the book!
	rm -rf ${D}/usr/share/doc/${PF}/full_docs/htmldocs/using_samba
	docinto examples
	cp -a examples/* ${D}/usr/share/doc/${PF}/examples
	prepalldocs
	# keep this next line *after* prepalldocs!
	dosym /usr/share/swat/using_samba /usr/share/doc/${PF}/using_samba
	# and we should unzip the html docs..
	gunzip ${D}/usr/share/doc/${PF}/full_docs/faq/*
	gunzip ${D}/usr/share/doc/${PF}/full_docs/htmldocs/*


	# link /usr/bin/smbmount to /sbin/mount.smbfs which allows it
	# to work transparently with the standard 'mount' command..
	dodir /sbin
	dosym /usr/bin/smbmount /sbin/mount.smbfs


	# make the smb backend symlink for cups printing support..
	if [ -n "`use cups`" ] ; then
		dodir /usr/lib/cups/backend
		dosym /usr/bin/smbspool /usr/lib/cups/backend/smb
	fi


	# make a symlink on /usr/lib/smbwrapper.so in /usr/sbin
	# to fix smbsh problem.  #6936
	dosym /usr/lib/smbwrapper.so /usr/sbin/smbwrapper.so


	# now the config files..
	insinto /etc
	doins ${FILESDIR}/nsswitch.conf-winbind
	doins ${FILESDIR}/nsswitch.conf-wins

	insinto /etc/samba
	doins ${FILESDIR}/smbusers
	doins ${FILESDIR}/smb.conf.example
	doins ${FILESDIR}/lmhosts

	insinto /etc/pam.d
	newins ${FILESDIR}/samba.pam samba
	doins ${FILESDIR}/system-auth-winbind

	exeinto /etc/init.d
	newexe ${FILESDIR}/samba-init samba
	newexe ${FILESDIR}/winbind-init winbind

	insinto /etc/xinetd.d
	newins ${FILESDIR}/swat.xinetd swat
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
	install -m0755 -o root -g root -d ${ROOT}/var/lib/samba/{netlogon,profiles}
	install -m0755 -o root -g root -d \
		${ROOT}/var/lib/samba/printers/{W32X86,WIN40,W32ALPHA,W32MIPS,W32PPC}


	# im guessing people dont need this anymore, it was quite a while ago...
	# /etc/smb is changed to /etc/samba, /var/run/smb to /var/run/samba
	#ewarn "******************************************************************"
	#ewarn "* NOTE: If you upgraded from an earlier version of samba you     *"
	#ewarn "*       must move your /etc/smb files to the more aptly suited   *"
	#ewarn "*       /etc/samba directory.  Also, please move the files in    *"
	#ewarn "*       /var/run/smb to /var/run/samba.  Lastly, if you have     *"
	#ewarn "*       the string "/etc/smb" in your smb.conf file, please      *"
	#ewarn "*       change that to "/etc/samba".  The old /etc/smb/codepages *"
	#ewarn "*       directory doesn't need to be moved into /etc/samba       *"
	#ewarn "*       because those files are now kept in the                  *"
	#ewarn "*       /var/lib/samba/codepages directory.                      *"
	#ewarn "******************************************************************"
}
