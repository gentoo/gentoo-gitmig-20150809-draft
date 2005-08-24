# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openssh/openssh-3.9_p1-r3.ebuild,v 1.4 2005/08/24 00:07:24 vapier Exp $

inherit eutils flag-o-matic ccc pam

# Make it more portable between straight releases
# and _p? releases.
PARCH=${P/_/}

SFTPLOG_PATCH_VER="1.2"
X509_PATCH="${PARCH}+x509h.diff.gz"
SELINUX_PATCH="openssh-3.9_p1-selinux.diff"
LDAP_PATCH="${PARCH/-/-lpk-}-0.3.6.patch"
HPN_PATCH="${PARCH}-hpn11.diff"

DESCRIPTION="Port of OpenBSD's free SSH release"
HOMEPAGE="http://www.openssh.com/"
SRC_URI="mirror://openbsd/OpenSSH/portable/${PARCH}.tar.gz
	ldap? ( http://www.opendarwin.org/en/projects/openssh-lpk/files/${LDAP_PATCH} )
	X509? ( http://roumenpetrov.info/openssh/x509h/${X509_PATCH} )
	hpn? ( http://www.psc.edu/networking/projects/hpn-ssh/${HPN_PATCH} )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="ipv6 static pam tcpd kerberos skey selinux chroot X509 ldap smartcard sftplogging hpn"

RDEPEND="pam? ( >=sys-libs/pam-0.73 >=sys-apps/shadow-4.0.2-r2 )
	kerberos? ( virtual/krb5 )
	selinux? ( sys-libs/libselinux )
	skey? ( >=app-admin/skey-1.1.5-r1 )
	ldap? ( net-nds/openldap )
	>=dev-libs/openssl-0.9.6d
	>=sys-libs/zlib-1.1.4
	smartcard? ( dev-libs/opensc )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
DEPEND="${RDEPEND}
	virtual/os-headers
	sys-devel/autoconf"
PROVIDE="virtual/ssh"

S=${WORKDIR}/${PARCH}

src_unpack() {
	unpack ${PARCH}.tar.gz
	cd "${S}"

	epatch "${FILESDIR}"/${P}-pamfix.patch.bz2
	#epatch "${FILESDIR}"/${P}-largekey.patch.bz2
	epatch "${FILESDIR}"/${P}-fix_suid.patch.bz2
	epatch "${FILESDIR}"/${P}-infoleak.patch #59361
	epatch "${FILESDIR}"/${P}-terminal_restore.patch.bz2
	epatch "${FILESDIR}"/${P}-configure-openct.patch #78730
	epatch "${FILESDIR}"/${P}-kerberos-detection.patch #80811

	use sftplogging && epatch ${FILESDIR}/${P}-sftplogging-1.2-gentoo.patch.bz2
	use alpha && epatch ${FILESDIR}/${PN}-3.5_p1-gentoo-sshd-gcc3.patch.bz2
	use skey && epatch ${FILESDIR}/${P}-skey.patch.bz2
	use chroot && epatch ${FILESDIR}/${P}-chroot.patch
	use X509 && epatch ${DISTDIR}/${X509_PATCH}
	use selinux && epatch ${FILESDIR}/${SELINUX_PATCH}.bz2
	use smartcard && epatch ${FILESDIR}/${P}-opensc.patch.bz2
	if use ldap ; then
		if use X509 || use sftplogging ; then
			ewarn "Sorry, x509/sftplogging and ldap don't get along"
		else
			epatch ${DISTDIR}/${LDAP_PATCH}
		fi
	fi
	use hpn && epatch ${DISTDIR}/${HPN_PATCH}

	autoconf || die "autoconf failed"
}

src_compile() {
	local myconf

	addwrite /dev/ptmx

	# make sure .sbss is large enough
	use skey && use alpha && append-ldflags -mlarge-data
	if use ldap ; then
		filter-flags -funroll-loops
		myconf="${myconf} --with-ldap"
	fi
	use selinux && append-flags "-DWITH_SELINUX"

	if use static ; then
		append-ldflags -static
		use pam && ewarn "Disabling pam support becuse of static flag"
		myconf="${myconf} --without-pam"
	else
		myconf="${myconf} $(use_with pam)"
	fi

	use ipv6 || myconf="${myconf} --with-ipv4-default"

	econf \
		--with-ldflags="${LDFLAGS}" \
		--disable-strip \
		--sysconfdir=/etc/ssh \
		--libexecdir=/usr/$(get_libdir)/misc \
		--datadir=/usr/share/openssh \
		--disable-suid-ssh \
		--with-privsep-path=/var/empty \
		--with-privsep-user=sshd \
		--with-md5-passwords \
		$(use_with kerberos kerberos5 /usr) \
		$(use_with tcpd tcp-wrappers) \
		$(use_with skey) \
		$(use_with smartcard opensc) \
		${myconf} \
		|| die "bad configure"

	emake || die "compile problem"
}

src_install() {
	make install-files DESTDIR="${D}" || die
	fperms 600 /etc/ssh/sshd_config
	dobin contrib/ssh-copy-id
	newinitd "${FILESDIR}"/sshd.rc6 sshd
	keepdir /var/empty

	newpamd "${FILESDIR}"/sshd.pam sshd
	dosed "/^#Protocol /s:.*:Protocol 2:" /etc/ssh/sshd_config
	use pam \
		&& dosed "/^#UsePAM /s:.*:UsePAM yes:" /etc/ssh/sshd_config \
		&& dosed "/^#PasswordAuthentication /s:.*:PasswordAuthentication no:" /etc/ssh/sshd_config

	doman contrib/ssh-copy-id.1
	dodoc ChangeLog CREDITS OVERVIEW README* TODO sshd_config
}

pkg_postinst() {
	enewgroup sshd 22
	enewuser sshd 22 -1 /var/empty sshd

	ewarn "Remember to merge your config files in /etc/ssh/ and then"
	ewarn "restart sshd: '/etc/init.d/sshd restart'."
	ewarn
	einfo "As of version 3.4 the default is to enable the UsePrivelegeSeparation"
	einfo "functionality, but please ensure that you do not explicitly disable"
	einfo "this in your configuration as disabling it opens security holes"
	einfo
	einfo "This revision has removed your sshd user id and replaced it with a"
	einfo "new one with UID 22.  If you have any scripts or programs that"
	einfo "that referenced the old UID directly, you will need to update them."
	einfo
	if use pam ; then
		einfo "Please be aware users need a valid shell in /etc/passwd"
		einfo "in order to be allowed to login."
		einfo
	fi
}
