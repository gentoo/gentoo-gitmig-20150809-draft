# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openssh/openssh-3.6.1_p2-r3.ebuild,v 1.2 2003/09/05 13:52:33 taviso Exp $

inherit eutils flag-o-matic ccc

# Make it more portable between straight releases
# and _p? releases.
PARCH=${P/_/}
X509_PATCH=${PARCH}+x509g2.diff.gz

S=${WORKDIR}/${PARCH}
DESCRIPTION="Port of OpenBSD's free SSH release"
HOMEPAGE="http://www.openssh.com/"
IUSE="ipv6 static pam tcpd kerberos selinux X509 skey"
SRC_URI="ftp://ftp.openbsd.org/pub/unix/OpenBSD/OpenSSH/portable/${PARCH}.tar.gz
	selinux? http://lostlogicx.com/gentoo/openssh_3.6p1-5.se1.diff.bz2
	X509? http://roumenpetrov.info/openssh/x509g2/${X509_PATCH}"

# openssh recognizes when openssl has been slightly upgraded and refuses to run.
# This new rev will use the new openssl.
RDEPEND="virtual/glibc
	pam? ( >=sys-libs/pam-0.73
		>=sys-apps/shadow-4.0.2-r2 )
	kerberos? ( app-crypt/mit-krb5 )
	selinux? ( sys-apps/selinux-small )
	afs? ( net-fs/openafs
		app-crypt/kth-krb ) :
	( krb4? ( app-crypt/kth-krb ) )
	skey? ( app-admin/skey )
	>=dev-libs/openssl-0.9.6d
	sys-libs/zlib
	>=sys-apps/sed-4"

DEPEND="${RDEPEND}
	dev-lang/perl
	sys-apps/groff
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~alpha"

src_unpack() {
	unpack ${PARCH}.tar.gz ; cd ${S}

	use selinux && epatch ${DISTDIR}/openssh_3.6p1-5.se1.diff.bz2
	use alpha && epatch ${FILESDIR}/${PN}-3.5_p1-gentoo-sshd-gcc3.patch
	use X509 && epatch ${DISTDIR}/${X509_PATCH}
}

src_compile() {
	local myconf

	use tcpd || myconf="${myconf} --without-tcp-wrappers"
	use tcpd && myconf="${myconf} --with-tcp-wrappers"
	use pam || myconf="${myconf} --without-pam"
	use pam && myconf="${myconf} --with-pam"
	use ipv6 || myconf="${myconf} --with-ipv4-default"
	use krb4 && myconf="${myconf} --with-kerberos4=/usr/athena"
	use kerberos && myconf="${myconf} --with-kerberos5"
	use skey || myconf="${myconf} --without-skey"
	use skey && {
		myconf="${myconf} --with-skey"
		
		# prevent the conftest from violating the sandbox
		sed -i 's#skey_keyinfo("")#"true"#g' ${S}/configure

		# make sure .sbss is large enough
		use alpha && append-ldflags -mlarge-data
	}

	if [ "`use afs`" ] && [ "`use krb4`" ]; then
		myconf="${myconf} --with-afs"
	elif [ "`use afs`" ] && [ -z "`use krb4`" ]; then
		myconf="${myconf} --with-afs"
		myconf="${myconf} --with-kerberos4=/usr/athena"
	fi
	
	use selinux && append-flags "-DWITH_SELINUX" 

	./configure \
		--prefix=/usr \
		--sysconfdir=/etc/ssh \
		--mandir=/usr/share/man \
		--libexecdir=/usr/lib/misc \
		--datadir=/usr/share/openssh \
		--disable-suid-ssh \
		--with-privsep-path=/var/empty \
		--with-privsep-user=sshd \
		--with-md5-passwords \
		--host=${CHOST} ${myconf} || die "bad configure"

	if [ "`use static`" ]
	then
		# statically link to libcrypto -- good for the boot cd
		sed -i "s:-lcrypto:/usr/lib/libcrypto.a:g" Makefile
	fi

	if [ "`use selinux`" ]
	then
		#add -lsecure
		sed -i "s:LIBS=\(.*\):LIBS=\1 -lsecure:" Makefile
	fi

	emake || die "compile problem"
}

src_install() {                               
	make install-files DESTDIR=${D} || die
	chmod 600 ${D}/etc/ssh/sshd_config
	dodoc ChangeLog CREDITS OVERVIEW README* TODO sshd_config
	insinto /etc/pam.d  ; newins ${FILESDIR}/sshd.pam sshd
	exeinto /etc/init.d ; newexe ${FILESDIR}/sshd.rc6 sshd
	touch ${D}/var/empty/.keep
}

pkg_preinst() {
	userdel sshd 2> /dev/null
	if ! groupmod sshd; then
		groupadd -g 90 sshd 2> /dev/null || \
			die "Failed to create sshd group"
	fi
	useradd -u 22 -g sshd -s /dev/null -d /var/empty -c "sshd" sshd || \
		die "Failed to create sshd user"
}

pkg_postinst() {
	# empty dir for the new priv separation auth chroot..
	install -d -m0755 -o root -g root ${ROOT}/var/empty

	einfo
	einfo "Remember to merge your config files in /etc/ssh!"
	einfo "As of version 3.4 the default is to enable the UsePrivelegeSeparation"
	einfo "functionality, but please ensure that you do not explicitly disable"
	einfo "this in your configuration as disabling it opens security holes"
	einfo
	einfo "This revision has removed your sshd user id and replaced it with a"
	einfo "new one with UID 22.  If you have any scripts or programs that"
	einfo "that referenced the old UID directly, you will need to update them."
	einfo
	if use pam >/dev/null 2>&1; then
		einfo "Please be aware users need a valid shell in /etc/passwd"
		einfo "in order to be allowed to login."
		einfo
	fi
}
