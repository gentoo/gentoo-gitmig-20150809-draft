# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openssh/openssh-3.6.1_p2.ebuild,v 1.1 2003/04/30 16:42:44 aliz Exp $

inherit eutils

IUSE="ipv6 static pam tcpd kerberos selinux"

# Make it more portable between straight releases
# and _p? releases.
PARCH=${P/_/}
S=${WORKDIR}/${PARCH}
DESCRIPTION="Port of OpenBSD's free SSH release"
HOMEPAGE="http://www.openssh.com/"
SRC_URI="ftp://ftp.openbsd.org/pub/unix/OpenBSD/OpenSSH/portable/${PARCH}.tar.gz
	selinux? http://lostlogicx.com/gentoo/openssh_3.6p1-5.se1.diff.bz2"

# openssh recognizes when openssl has been slightly upgraded and refuses to run.
# This new rev will use the new openssl.
RDEPEND="virtual/glibc
	pam? ( >=sys-libs/pam-0.73 >=sys-apps/shadow-4.0.2-r2 )
	kerberos? ( app-crypt/krb5 )
	selinux? ( sys-apps/selinux-small )
	>=dev-libs/openssl-0.9.6d
	sys-libs/zlib"

DEPEND="${RDEPEND}
	dev-lang/perl
	sys-apps/groff
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"


SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa arm"

src_unpack() {
	unpack ${PARCH}.tar.gz
	cd ${S}
	use selinux && epatch ${DISTDIR}/openssh_3.6p1-5.se1.diff.bz2

	if [ `use alpha` ]; then
		 epatch ${FILESDIR}/${PN}-3.5_p1-gentoo-sshd-gcc3.patch || die
	fi
}

src_compile() {
	local myconf
	use tcpd || myconf="${myconf} --without-tcp-wrappers"
	use tcpd && myconf="${myconf} --with-tcp-wrappers"
	use pam  || myconf="${myconf} --without-pam"
	use pam  && myconf="${myconf} --with-pam"
	use ipv6 || myconf="${myconf} --with-ipv4-default"

	# app-crypt/krb5
	use kerberos && myconf="${myconf} --with-kerberos5"

	# app-crypt/kth-krb
	# KTH's implementation of kerberos IV
	# KTH_KRB="yes" emerge openssh-3.5_p1-r1.ebuild
	if [ ! -z $KTH_KRB ]; then
		myconf="${myconf} --with-kerberos4=/usr/athena"
	fi
	
	use selinux && CFLAGS="${CFLAGS} -DWITH_SELINUX" 

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
		perl -pi -e "s|-lcrypto|/usr/lib/libcrypto.a|g" Makefile
	fi

	if [ "`use selinux`" ]
	then
		#add -lsecure
		sed "s:LIBS=\(.*\):LIBS=\1 -lsecure:" < Makefile > Makefile.new
		mv Makefile.new Makefile
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
