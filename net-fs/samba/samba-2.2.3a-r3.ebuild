# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba/samba-2.2.3a-r3.ebuild,v 1.1 2002/05/04 03:29:35 woodchip Exp $

DESCRIPTION="SAMBA is a suite of SMB and CIFS client/server programs for UNIX"
HOMEPAGE="http://samba.org http://www.amherst.edu/~bbstone/howto/samba.html"

S=${WORKDIR}/${P}
SRC_URI="http://us1.samba.org/samba/ftp/${P}.tar.gz"
#	http://www.amherst.edu/~bbstone/recycle_bin/${PV/a/}/loadparm.c.patch
#	http://www.amherst.edu/~bbstone/recycle_bin/${PV/a/}/proto.h.patch
#	http://www.amherst.edu/~bbstone/recycle_bin/${PV/a/}/reply.c.patch"

RDEPEND="virtual/glibc
	>=sys-libs/pam-0.72
	acl? ( sys-apps/acl )
	cups? ( net-print/cups )"
	# needs testing -- ssl? ( >=dev-libs/openssl-0.9.6 )
DEPEND="${RDEPEND}
	sys-devel/autoconf
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	unpack ${P}.tar.gz ; cd ${S}
	use afs && ( patch -p0 < ${FILESDIR}/samba-2.2.1a-afs.diff || die )
	patch -p0 < ${FILESDIR}/samba-2.2.2-smbmount.diff || die
	patch -p1 < ${FILESDIR}/samba-2.2.3a-pam_smbpass.diff || die
	patch -p1 < ${FILESDIR}/samba-2.2.3a-cli_spoolss_notify.patch || die
	patch -p1 < ${FILESDIR}/samba-2.2.3a-srv_spoolss_nt.patch || die

	# network recycle bin must be enabled in your smb.conf per share
	cd ${S}/source
	patch -p0 < ${FILESDIR}/samba-2.2.3a-loadparm.c.patch || die
	patch -p0 < ${FILESDIR}/samba-2.2.3a-proto.h.patch || die
	patch -p0 < ${FILESDIR}/samba-2.2.3a-reply.c.patch || die

	# makes cups not absolutely required
	if [ ! "`use cups`" ] ; then
		cd ${S}/source
		cp configure.in configure.in.orig
		sed -e "s:AC_CHECK_LIB(cups,httpConnect)::" configure.in.orig > configure.in
	fi

	# fix kerberos include file collision
	cd ${S}/source/include
	mv profile.h smbprofile.h
	sed -e "s:profile\.h:smbprofile.h:" includes.h > includes.h.new
	mv includes.h.new includes.h

	cd ${S}/source
	autoconf || die
}

src_compile() {
	local myconf
	use afs && myconf="${myconf} --with-afs"
	use acl && myconf="${myconf} --with-acl-support"
	# ssl needs testing...
	myconf="${myconf} --without-ssl"

	export CFLAGS="${CFLAGS} -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE"
	cd ${S}/source
	./configure \
		--prefix=/usr \
		--libdir=/etc/samba \
		--sbindir=/usr/sbin \
		--sysconfdir=/etc/samba \
		--localstatedir=/var/log \
		--with-mandir=/usr/share/man \
		--with-lockdir=/var/run/samba \
		--with-swatdir=/usr/share/swat \
		--with-privatedir=/etc/samba/private \
		--with-codepagedir=/var/lib/samba/codepages \
		--with-pam --with-pam_smbpass \
		--without-sambabook \
		--without-automount \
		--without-spinlocks \
		--with-netatalk \
		--with-smbmount \
		--with-profile \
		--with-quotas \
		--with-syslog \
		--with-msdfs \
		--with-utmp \
		--with-vfs \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	cd ${S}/source
	dodir /sbin /etc/samba /usr/share/swat /var/log /var/run/samba \
		/lib/security /var/lib/samba/codepages

	make install \
		prefix=${D}/usr \
		BASEDIR=${D}/usr \
		VARDIR=${D}/var/log \
		LIBDIR=${D}/etc/samba \
		SBINDIR=${D}/usr/sbin \
		MANDIR=${D}/usr/share/man \
		LOCKDIR=${D}/var/run/samba \
		SWATDIR=${D}/usr/share/swat \
		PRIVATEDIR=${D}/etc/samba/private \
		CODEPAGEDIR=${D}/var/lib/samba/codepages || die

	# we specified PRIVATEDIR=/etc/samba/private
	rm -rf ${D}/usr/private

	# link /usr/bin/smbmount to /sbin/mount.smbfs which allows it
	# to work transparently with standard 'mount' command
	dosym /usr/bin/smbmount /sbin/mount.smbfs

	# handy scripts for user management
	cd ${S}/source/script
	exeinto /usr/sbin
	doexe convert_smbpasswd mknissmbpasswd.sh mknissmbpwdtbl.sh mksmbpasswd.sh

	# place this correctly
	mv ${D}/usr/bin/pam_smbpass.so ${D}/lib/security/pam_smbpass.so

	# make the smb backend symlink for smb printing support with cups
	if [ "`use cups`" ] ; then
		dodir /usr/lib/cups/backend
		dosym /usr/bin/smbspool /usr/lib/cups/backend/smb
	fi

	# too many docs to sort through -- install them all :)
	cd ${S}
	dodoc COPYING Manifest README Roadmap WHATSNEW.txt
	docinto full_docs ; cp -a docs/* ${D}/usr/share/doc/${PF}/full_docs
	docinto examples ; cp -a examples/* ${D}/usr/share/doc/${PF}/examples
	prepalldocs

	insinto /etc/samba
	newins examples/smb.conf.default smb.conf.example
	doins ${FILESDIR}/smbusers
	insinto /etc/pam.d ; newins ${FILESDIR}/samba.pam samba
	exeinto /etc/init.d ; newexe ${FILESDIR}/samba.rc6 samba
	insinto /etc/xinetd.d ; newins ${FILESDIR}/swat.xinetd swat
}

pkg_preinst() {
	if [ "$ROOT" = "/" ] && [ -e /dev/shm/.init.d/started/samba ] ; then
		/etc/init.d/samba stop
	fi
}

pkg_prerm() {
	if [ "$ROOT" = "/" ] && [ -e /dev/shm/.init.d/started/samba ] ; then
		/etc/init.d/samba stop
	fi
}

pkg_postinst() {

	# we touch ${D}/etc/samba/smb.conf so that people installing samba
	# just to mount smb shares don't get annoying warnings all the time.
	if [ ! -e ${ROOT}/etc/samba/smb.conf ] ; then
		touch ${ROOT}/etc/samba/smb.conf
	fi

	# might be empty for some people so do it here..
	install -m0700 -o root -g root -d ${ROOT}/etc/samba/private

	# /etc/smb is changed to /etc/samba; /var/run/smb to /var/run/samba
	ewarn "******************************************************************"
	ewarn "* NOTE: If you upgraded from an earlier version of samba you     *"
	ewarn "*       must move your /etc/smb files to the more aptly suited   *"
	ewarn "*       /etc/samba directory.  Also, please move the files in    *"
	ewarn "*       /var/run/smb to /var/run/samba.  Lastly, if you have     *"
	ewarn "*       the string "/etc/smb" in your smb.conf file, please      *"
	ewarn "*       change that to "/etc/samba".  The old /etc/smb/codepages *"
	ewarn "*       directory doesn't need to be moved into /etc/samba       *"
	ewarn "*       because those files are now kept in the                  *"
	ewarn "*       /var/lib/samba/codepages directory.                      *"
	ewarn "*                                                                *"
	ewarn "*       If you need help with upgrading, email me:               *"
	ewarn "*       woodchip@gentoo.org and I'll assist you.                 *"
	ewarn "******************************************************************"

	#echo "##"
	#echo " If you had samba running earlier, you'll need to start it again. Also, please note"
	#echo " that you must configure /etc/samba/smb.conf before samba (the server) will work properly."
	#echo " Mounting smb shares and the smbclient program should work immediately.  To accomplish"
	#echo " this there is an empty /etc/samba/smb.conf file installed."
	#echo
	#echo " To mount smb shares, type something like this. You will need kernel SMB support first:"
	#echo " % mount -t smbfs -o username=drobbins,password=foo,ip=192.168.1.1 //mybox/drobbins /mnt/foo"
	#echo " If you wish to allow normal users to mount smb shares, type the following as root:"
	#echo " % chmod u+s /usr/bin/smbmnt"
	#echo "##"
}
