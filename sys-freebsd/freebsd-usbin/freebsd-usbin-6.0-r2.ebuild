# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-usbin/freebsd-usbin-6.0-r2.ebuild,v 1.1 2006/04/22 13:35:01 flameeyes Exp $

inherit bsdmk freebsd flag-o-matic eutils

DESCRIPTION="FreeBSD /usr/sbin tools"
SLOT="0"
KEYWORDS="~x86-fbsd"

IUSE="atm bluetooth tcpd ssl usb ipv6 acpi ipfilter isdn pam ssl radius
	netgraph minimal ipsec nis pam suid nat radius"

SRC_URI="mirror://gentoo/${P}.tar.bz2
		mirror://gentoo/${CONTRIB}.tar.bz2
		mirror://gentoo/${UBIN}.tar.bz2
		mirror://gentoo/${LIB}.tar.bz2
		mirror://gentoo/${SBIN}.tar.bz2
		mirror://gentoo/${ETC}.tar.bz2
		nis? ( mirror://gentoo/${LIBEXEC}.tar.bz2 )"

RDEPEND="=sys-freebsd/freebsd-lib-${RV}*
	=sys-freebsd/freebsd-libexec-${RV}*
	ssl? ( dev-libs/openssl )
	tcpd? ( sys-apps/tcp-wrappers )
	net-libs/libpcap"
DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-mk-defs-${RV}*
	=sys-freebsd/freebsd-sources-${RV}*
	sys-apps/texinfo
	sys-devel/flex"

PROVIDE="virtual/logger"

S="${WORKDIR}/usr.sbin"

pkg_setup() {
	# Release crunch is something like minimal. It seems to remove everything
	# which is not needed to work.
	use minimal && mymakeopts="${mymakeopts} RELEASE_CRUNCH= "

	use atm || mymakeopts="${mymakeopts} NO_ATM= "
	use bluetooth || mymakeopts="${mymakeopts} NO_BLUETOOTH= "
	use ipv6 || mymakeopts="${mymakeopts} NO_INET6= "
	use ipfilter || mymakeopts="${mymakeopts} NO_IPFILTER= "
	use ssl || mymakeopts="${mymakeopts} NO_OPENSSL= NO_CRYPT= "
	use usb || mymakeopts="${mymakeopts} NO_USB= "
	use acpi || mymakeopts="${mymakeopts} NO_ACPI= "
	use isdn || mymakeopts="${mymakeopts} NO_I4B= "
	use pam || mymakeopts="${mymakeopts} NO_PAM= "
	use radius || mymakeopts="${mymakeopts} NO_RADIUS= "
	use suid || mymakeopts="${mymakeopts} NO_SUID= "
	use ipsec || mymakeopts="${mymakeopts} NO_IPSEC= "
	use nis || mymakeopts="${mymakeopts} NO_NIS= "
	use nat || mymakeopts="${mymakeopts} NO_NAT= "
	use pam || mymakeopts="${mymakeopts} NO_PAM= "
	use suid || mymakeopts="${mymakeopts} NO_SUID= PPP_NOSUID= "
	use radius || mymakeopts="${mymakeopts} NO_RADIUS= "
	use tcpd || mymakeopts="${mymakeopts} NO_WRAP= "

	mymakeopts="${mymakeopts} NO_MAILWRAPPER= NO_BIND= NO_SENDMAIL= NO_PF= NO_AUTHPF= NO_LPR="

	# kldxref does not build with -O2
	replace-flags "-O?" "-O1"
}

PATCHES="${FILESDIR}/${PN}-${RV}-fixmakefiles.patch
	${FILESDIR}/${PN}-nowrap.patch"

REMOVE_SUBDIRS="
	named named-checkzone named-checkconf rndc rndc-confgen
		dnssec-keygen dnssec-signzone
	tcpdchk tcpdmatch
	sendmail praliases editmap mailstats makemap
	sysinstall cron mailwrapper ntp bsnmpd mount_smbfs
	tcpdump ndp traceroute pkg_install inetd
	wpa/wpa_supplicant wpa/hostapd zic"

src_unpack() {
	freebsd_src_unpack
	ln -s "/usr/src/sys-${RV}" "${WORKDIR}/sys"
	ln -s "/usr/include" "${WORKDIR}/include"
}

src_install() {
	# By creating these two directories we avoid having to do a
	# more complex hack inside lpr/SMM.doc and nologin makefiles.
	dodir /usr/share/doc
	dodir /sbin
	dodir /usr/libexec

	# FILESDIR is used by some makefiles which will install files
	# in the wrong place, just put it in the doc directory.
	mkinstall DOCDIR=/usr/share/doc/${PF} || die "Install failed"

	for util in nfs nfsmount rpcbind syslogd moused powerd; do
		newinitd ${FILESDIR}/${util}.initd ${util}
		[[ -e ${FILESDIR}/${util}.confd ]] && \
			newconfd ${FILESDIR}/${util}.confd ${util}
	done

	for class in daily monthly weekly; do
		cat - > ${T}/periodic.${class} <<EOS
#!/bin/sh
/usr/sbin/periodic ${class}
EOS
		exeinto /etc/cron.${class}
		newexe ${T}/periodic.${class} periodic
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
		rm -f ${D}/etc/isdn/Makefile
	fi

	if use bluetooth; then
		insinto /etc/bluetooth
		doins bluetooth/*
		rm -f ${D}/etc/bluetooth/Makefile
	fi

	# Install the periodic stuff (needs probably to be ported in a more
	# gentooish way)
	cd "${WORKDIR}/etc/periodic"

	doperiodic daily daily/*.accounting
	doperiodic monthly monthly/*.accounting
}

pkg_postinst() {
	for logfile in messages security auth.log maillog lpd-errs xferlog cron \
		debug.log slip.log ppp.log; do
		[[ -f ${ROOT}/var/log/${logfile} ]] || touch ${ROOT}/var/log/${logfile}
	done
}

