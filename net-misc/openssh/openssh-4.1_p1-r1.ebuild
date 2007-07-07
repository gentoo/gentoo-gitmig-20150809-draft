# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openssh/openssh-4.1_p1-r1.ebuild,v 1.17 2007/07/07 16:59:47 armin76 Exp $

inherit eutils flag-o-matic ccc pam

# Make it more portable between straight releases
# and _p? releases.
PARCH=${P/_/}

SFTPLOG_PATCH_VER="1.2"
X509_PATCH="${PARCH}+x509-5.2.diff.gz"
SELINUX_PATCH="openssh-3.9_p1-selinux.diff"
SECURID_PATCH="${PARCH}+SecurID_v1.3.1.patch"
LDAP_PATCH="${PARCH/-/-lpk-}-0.3.6.patch"
HPN_PATCH="${PARCH}-hpn11.diff"

DESCRIPTION="Port of OpenBSD's free SSH release"
HOMEPAGE="http://www.openssh.com/"
SRC_URI="mirror://openbsd/OpenSSH/portable/${PARCH}.tar.gz
	ldap? ( http://www.opendarwin.org/en/projects/openssh-lpk/files/${LDAP_PATCH} )
	X509? ( http://roumenpetrov.info/openssh/x509-5.2/${X509_PATCH} )
	hpn? ( http://www.psc.edu/networking/projects/hpn-ssh/${HPN_PATCH} )
	smartcard? ( http://www.omniti.com/~jesus/projects/${SECURID_PATCH} )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 m68k mips ~ppc ~ppc64 s390 sh ~sparc x86"
IUSE="ipv6 static pam tcpd kerberos skey selinux chroot X509 ldap smartcard sftplogging hpn libedit"

RDEPEND="pam? ( virtual/pam )
	kerberos? ( virtual/krb5 )
	selinux? ( sys-libs/libselinux )
	skey? ( >=app-admin/skey-1.1.5-r1 )
	ldap? ( net-nds/openldap )
	libedit? ( dev-libs/libedit )
	>=dev-libs/openssl-0.9.6d
	>=sys-libs/zlib-1.2.3
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

	sed -i \
		-e '/_PATH_XAUTH/s:/usr/X11R6/bin/xauth:/usr/bin/xauth:' \
		pathnames.h || die

	epatch "${FILESDIR}"/openssh-3.9_p1-kerberos-detection.patch #80811
	epatch "${FILESDIR}"/openssh-4.2_p1-cross-compile.patch #120567

	use X509 && epatch "${DISTDIR}"/${X509_PATCH}
	use sftplogging && epatch "${FILESDIR}"/openssh-4.0_p1-sftplogging-1.2-gentoo.patch.bz2
	use skey && epatch "${FILESDIR}"/openssh-3.9_p1-skey.patch
	use chroot && epatch "${FILESDIR}"/openssh-3.9_p1-chroot.patch
	use selinux && epatch "${FILESDIR}"/${SELINUX_PATCH}
	use smartcard && epatch "${FILESDIR}"/openssh-3.9_p1-opensc.patch
	if ! use X509 ; then
		if [[ -n ${SECURID_PATCH} ]] && use smartcard ; then
			epatch "${DISTDIR}"/${SECURID_PATCH} "${FILESDIR}"/openssh-securid-1.3.1-updates.patch
			use ldap && epatch "${FILESDIR}"/openssh-4.0_p1-smartcard-ldap-happy.patch
		fi
		if use ldap ; then
			use sftplogging \
				&& ewarn "Sorry, sftplogging and ldap don't get along, disabling ldap" \
				|| epatch "${DISTDIR}"/${LDAP_PATCH}
		fi
	elif use smartcard || use ldap ; then
		ewarn "Sorry, x509 and smartcard/ldap don't get along"
	fi
	use hpn && epatch "${DISTDIR}"/${HPN_PATCH}

	sed -i '/LD.*ssh-keysign/s:$: -Wl,-z,now:' Makefile.in || die "setuid"

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
		$(use_with libedit) \
		$(use_with kerberos kerberos5 /usr) \
		$(use_with tcpd tcp-wrappers) \
		$(use_with skey) \
		$(use_with smartcard opensc) \
		${myconf} \
		|| die "bad configure"

	emake || die "compile problem"
}

src_install() {
	make install-nokeys DESTDIR="${D}" || die
	fperms 600 /etc/ssh/sshd_config
	dobin contrib/ssh-copy-id
	newinitd "${FILESDIR}"/sshd.rc6 sshd
	newconfd "${FILESDIR}"/sshd.confd sshd
	keepdir /var/empty

	newpamd "${FILESDIR}"/sshd.pam_include sshd
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
