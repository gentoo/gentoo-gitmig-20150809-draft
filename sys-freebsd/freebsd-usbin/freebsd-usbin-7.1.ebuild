# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-usbin/freebsd-usbin-7.1.ebuild,v 1.1 2009/01/22 21:06:27 the_paya Exp $

inherit bsdmk freebsd flag-o-matic eutils

DESCRIPTION="FreeBSD /usr/sbin tools"
SLOT="0"
KEYWORDS="~sparc-fbsd ~x86-fbsd"

IUSE="acpi atm bluetooth build ipsec ipv6 ipfilter isdn minimal nat nis
	pam radius ssl suid tcpd usb"

SRC_URI="mirror://gentoo/${P}.tar.bz2
		mirror://gentoo/${CONTRIB}.tar.bz2
		mirror://gentoo/${UBIN}.tar.bz2
		mirror://gentoo/${LIB}.tar.bz2
		mirror://gentoo/${SBIN}.tar.bz2
		mirror://gentoo/${ETC}.tar.bz2
		mirror://gentoo/${GNU}.tar.bz2
		nis? ( mirror://gentoo/${LIBEXEC}.tar.bz2 )
		build? ( mirror://gentoo/${SYS}.tar.bz2
			mirror://gentoo/${INCLUDE}.tar.bz2 )"

RDEPEND="=sys-freebsd/freebsd-lib-${RV}*
	=sys-freebsd/freebsd-libexec-${RV}*
	acpi? ( sys-power/iasl )
	build? ( sys-apps/baselayout )
	ssl? ( dev-libs/openssl )
	tcpd? ( sys-apps/tcp-wrappers )
	dev-libs/libedit
	net-libs/libpcap"
DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-mk-defs-${RV}*
	!build? ( =sys-freebsd/freebsd-sources-${RV}* )
	sys-apps/texinfo
	sys-devel/flex"

PROVIDE="virtual/logger"

S="${WORKDIR}/usr.sbin"

pkg_setup() {
	# Release crunch is something like minimal. It seems to remove everything
	# which is not needed to work.
	use minimal && mymakeopts="${mymakeopts} RELEASE_CRUNCH= "

	use acpi || mymakeopts="${mymakeopts} NO_ACPI= "
	use atm || mymakeopts="${mymakeopts} NO_ATM= "
	use bluetooth || mymakeopts="${mymakeopts} NO_BLUETOOTH= "
	use ipsec || mymakeopts="${mymakeopts} NO_IPSEC= "
	use ipfilter || mymakeopts="${mymakeopts} NO_IPFILTER= "
	use ipv6 || mymakeopts="${mymakeopts} NO_INET6= "
	use isdn || mymakeopts="${mymakeopts} NO_I4B= "
	use nat || mymakeopts="${mymakeopts} NO_NAT= "
	use nis || mymakeopts="${mymakeopts} NO_NIS= "
	use pam || mymakeopts="${mymakeopts} NO_PAM= "
	use radius || mymakeopts="${mymakeopts} NO_RADIUS= "
	use suid || mymakeopts="${mymakeopts} NO_SUID= PPP_NOSUID= "
	use tcpd || mymakeopts="${mymakeopts} NO_WRAP= "
	use ssl || mymakeopts="${mymakeopts} NO_OPENSSL= NO_CRYPT= "
	use suid || mymakeopts="${mymakeopts} NO_SUID= "
	use usb || mymakeopts="${mymakeopts} NO_USB= "

	mymakeopts="${mymakeopts} NO_MAILWRAPPER= NO_BIND= NO_SENDMAIL= NO_PF= NO_AUTHPF= NO_LPR="
}

PATCHES="${FILESDIR}/${PN}-7.0-nowrap.patch
	${FILESDIR}/${PN}-adduser.patch"

REMOVE_SUBDIRS="
	named named-checkzone named-checkconf rndc rndc-confgen
	dnssec-keygen dnssec-signzone
	tcpdchk tcpdmatch
	sendmail praliases editmap mailstats makemap
	sysinstall cron mailwrapper ntp bsnmpd
	tcpdump ndp traceroute inetd
	wpa/wpa_supplicant wpa/hostapd wpa/hostapd_cli wpa/wpa_cli wpa/wpa_passphrase
	zic amd
	pkg_install freebsd-update"

src_unpack() {
	freebsd_src_unpack

	if ! use build; then
		ln -s "/usr/src/sys-${RV}" "${WORKDIR}/sys"
		ln -s "/usr/include" "${WORKDIR}/include"
	else
		dummy_mk mount_smbfs
	fi
}

src_compile() {
	strip-flags
	append-flags -I "${WORKDIR}/sys"

	NOFLAGSTRIP="yes" freebsd_src_compile
}

src_install() {
	# By creating these directories we avoid having to do a
	# more complex hack
	dodir /usr/share/doc
	dodir /sbin
	dodir /usr/libexec
	dodir /usr/bin

	# FILESDIR is used by some makefiles which will install files
	# in the wrong place, just put it in the doc directory.
	mkinstall DOCDIR=/usr/share/doc/${PF} || die "Install failed"

	# Most of these now come from openrc.
	for util in nfs rpc.statd rpc.lockd; do
		newinitd "${FILESDIR}/"${util}.initd ${util}
		[[ -e "${FILESDIR}"/${util}.confd ]] && \
			newconfd "${FILESDIR}"/${util}.confd ${util}
	done

	for class in daily monthly weekly; do
		cat - > "${T}/periodic.${class}" <<EOS
#!/bin/sh
/usr/sbin/periodic ${class}
EOS
		exeinto /etc/cron.${class}
		newexe "${T}/periodic.${class}" periodic
	done

	# Install the pw.conf file to let pw use Gentoo's skel location
	insinto /etc
	doins "${FILESDIR}/pw.conf"

	cd "${WORKDIR}/etc"
	doins amd.map apmd.conf syslog.conf newsyslog.conf usbd.conf

	insinto /etc/ppp
	doins ppp/ppp.conf

	if use isdn; then
		insinto /etc/isdn
		doins isdn/*
		rm -f "${D}"/etc/isdn/Makefile
	fi

	if use bluetooth; then
		insinto /etc/bluetooth
		doins bluetooth/*
		rm -f "${D}"/etc/bluetooth/Makefile
	fi

	# Install the periodic stuff (needs probably to be ported in a more
	# gentooish way)
	cd "${WORKDIR}/etc/periodic"

	doperiodic daily daily/*.accounting
	doperiodic monthly monthly/*.accounting
}

pkg_postinst() {
	# We need to run pwd_mkdb if key files are not present
	# If they are, then there is no need to run pwd_mkdb
	if [[ ! -e "${ROOT}etc/passwd" || ! -e "${ROOT}etc/pwd.db" || ! -e "${ROOT}etc/spwd.db" ]] ; then
		if [[ -e "${ROOT}etc/master.passwd" ]] ; then
			einfo "Generating passwd files from ${ROOT}etc/master.passwd"
			"${ROOT}"usr/sbin/pwd_mkdb -p -d "${ROOT}etc" "${ROOT}etc/master.passwd"
		else
			eerror "${ROOT}etc/master.passwd does not exist!"
			eerror "You will no be able to log into your system!"
		fi
	fi

	for logfile in messages security auth.log maillog lpd-errs xferlog cron \
		debug.log slip.log ppp.log; do
		[[ -f "${ROOT}/var/log/${logfile}" ]] || touch "${ROOT}/var/log/${logfile}"
	done
}
