# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba/samba-2.2.2-r8.ebuild,v 1.1 2002/01/29 23:23:19 woodchip Exp $

DESCRIPTION="SAMBA is a suite of SMB and CIFS client/server programs for UNIX"
HOMEPAGE="http://samba.org http://www.amherst.edu/~bbstone/howto/samba.html"

S=${WORKDIR}/${P}
SRC_URI="http://us1.samba.org/samba/ftp/${P}.tar.gz
	http://www.amherst.edu/~bbstone/recycle_bin/2.2.2/loadparm.c.patch
	http://www.amherst.edu/~bbstone/recycle_bin/2.2.2/proto.h.patch
	http://www.amherst.edu/~bbstone/recycle_bin/2.2.2/reply.c.patch"

RDEPEND="virtual/glibc >=sys-libs/pam-0.72 cups? ( net-print/cups )"
# needs testing -- ssl? ( >=dev-libs/openssl-0.9.6 )"
DEPEND="${RDEPEND} tcpd? ( >=sys-apps/tcp-wrappers-7.6 ) sys-devel/autoconf"

src_unpack() {

	unpack ${P}.tar.gz ; cd ${S}
	use afs && ( patch -p0 < ${FILESDIR}/samba-2.2.1a-afs.diff || die )
	patch -p0 < ${FILESDIR}/samba-2.2.2-smbmount.diff || die
	patch -p1 < ${FILESDIR}/samba-2.2.2-XFS-quota.diff || die

	#network recycle bin must be enabled in your smb.conf per share
	cd ${S}/source
	patch -p0 < ${DISTDIR}/loadparm.c.patch || die
	patch -p0 < ${DISTDIR}/proto.h.patch || die
	patch -p0 < ${DISTDIR}/reply.c.patch || die

	#makes cups not absolutely required
	if [ ! "`use cups`" ] ; then
		cd ${S}/source
		cp configure.in configure.in.orig
		sed -e "s:AC_CHECK_LIB(cups,httpConnect)::" configure.in.orig > configure.in
		autoconf || die
	fi

	#fix kerberos include file collision
	cd ${S}/source/include
	mv profile.h smbprofile.h
	sed -e "s:profile\.h:smbprofile.h:" includes.h > includes.h.new
	mv includes.h.new includes.h
}

src_compile() {

	local myconf
	use afs && myconf="--with-afs"
	use acl && myconf="${myconf} --with-acl-support"
	#ssl needs testing...
	myconf="${myconf} --without-ssl"

	export CFLAGS="${CFLAGS} -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE"
	cd ${S}/source
	./configure \
		--prefix=/usr \
		--libdir=/etc/smb \
		--sbindir=/usr/sbin \
		--sysconfdir=/etc/smb \
		--localstatedir=/var/log \
		--with-lockdir=/var/run/smb \
		--with-mandir=/usr/share/man \
		--with-swatdir=/usr/share/swat \
		--with-privatedir=/etc/smb/private \
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
	dodir /sbin /etc/smb /usr/share/swat /var/log /var/run/smb /lib/security

	make install \
		prefix=${D}/usr \
		BASEDIR=${D}/usr \
		LIBDIR=${D}/etc/smb \
		VARDIR=${D}/var/log \
		LOCKDIR=${D}/var/lock \
		SBINDIR=${D}/usr/sbin \
		MANDIR=${D}/usr/share/man \
		SWATDIR=${D}/usr/share/swat \
		PRIVATEDIR=${D}/etc/smb/private || die

	#we specified PRIVATEDIR=/etc/smb/private
	rm -rf ${D}/usr/private
	diropts -m 0700 ; dodir /etc/smb/private

	#link /usr/bin/smbmount to /sbin/mount.smbfs which allows it
	#to work transparently with standard 'mount' command
	dosym /usr/bin/smbmount /sbin/mount.smbfs

	#handy scripts for user management
	cd ${S}/source/script
	exeinto /usr/sbin
	doexe convert_smbpasswd mknissmbpasswd.sh mknissmbpwdtbl.sh mksmbpasswd.sh

	#place this correctly
	mv ${D}/usr/bin/pam_smbpass.so ${D}/lib/security/pam_smbpass.so

	#too many docs to sort through.  install 'em all :>
	cd ${S}
	dodoc COPYING Manifest README Roadmap WHATSNEW.txt
	docinto full_docs ; cp -a docs/* ${D}/usr/share/doc/${PF}/full_docs
	docinto examples ; cp -a examples/* ${D}/usr/share/doc/${PF}/examples
	prepalldocs

	insinto /etc/pam.d ; newins ${FILESDIR}/samba.pam samba
	insinto /etc/smb ; newins examples/smb.conf.default smb.conf.example
	exeinto /etc/init.d ; newexe ${FILESDIR}/samba.rc6 samba
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

	#we touch ${D}/etc/smb/smb.conf so that people installing samba
	#just to mount smb shares don't get annoying warnings all the time.
	if [ ! -e ${ROOT}etc/smb/smb.conf ] ; then
		touch ${ROOT}etc/smb/smb.conf
	fi

	echo "##"
	echo " If you had samba running earlier, you'll need to start it again. Also, please note"
	echo " that you must configure /etc/smb/smb.conf before samba (the server) will work properly."
	echo " Mounting smb shares and the smbclient program should work immediately.  To accomplish"
	echo " this there is an empty /etc/smb/smb.conf file installed."
	echo
	echo " To mount smb shares, type something like this. You will need kernel SMB support first:"
	echo " % mount -t smbfs -o username=drobbins,password=foo,ip=192.168.1.1 //mybox/drobbins /mnt/foo"
	echo " If you wish to allow normal users to mount smb shares, type the following as root:"
	echo " % chmod u+s /usr/bin/smbmnt"
	echo "##"
}
