# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/nullmailer/nullmailer-1.02-r2.ebuild,v 1.4 2007/10/01 21:18:18 swegener Exp $

inherit eutils flag-o-matic mailer

MY_P="${P/_rc/RC}"
S=${WORKDIR}/${MY_P}
DEBIAN_PV="1"
DEBIAN_SRC="${MY_P/-/_}-${DEBIAN_PV}.diff.gz"
DESCRIPTION="Simple relay-only local mail transport agent"
SRC_URI="http://untroubled.org/${PN}/${MY_P}.tar.gz
		mirror://debian/pool/main/n/${PN}/${DEBIAN_SRC}"
HOMEPAGE="http://untroubled.org/nullmailer/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="virtual/libc
		sys-apps/groff"
RDEPEND="virtual/libc
		>=sys-process/supervise-scripts-3.2
		>=sys-process/daemontools-0.76-r1
		sys-apps/shadow"
PROVIDE="virtual/mta"

NULLMAILER_GROUP_NAME=nullmail
NULLMAILER_GROUP_GID=88
NULLMAILER_USER_NAME=nullmail
NULLMAILER_USER_UID=88
NULLMAILER_USER_SHELL=-1
NULLMAILER_USER_GROUPS=nullmail
NULLMAILER_USER_HOME=/var/nullmailer

setupuser() {
	enewgroup ${NULLMAILER_GROUP_NAME} ${NULLMAILER_GROUP_GID}
	enewuser ${NULLMAILER_USER_NAME} ${NULLMAILER_USER_UID} ${NULLMAILER_USER_SHELL} ${NULLMAILER_USER_HOME} ${NULLMAILER_USER_GROUPS}
}

src_unpack() {
	unpack ${MY_P}.tar.gz
	EPATCH_OPTS="-d ${S} -p1" \
	epatch ${DISTDIR}/${DEBIAN_SRC}
	EPATCH_OPTS="-d ${S} -p1" \
	epatch ${S}/debian/patches/03ipv6.diff || die "IPV6 patch failed"
	EPATCH_OPTS="-d ${S} -p1" \
	epatch ${S}/debian/patches/05syslog.diff || die "daemon/syslog patch failed"
	# this fixes the debian daemon/syslog to actually compile
	sed -i.orig \
		-e '/^nullmailer_send_LDADD/s, =, = ../lib/cli++/libcli++.a,' \
		${S}/src/Makefile.am || die "Sed failed"
}

pkg_setup() {
	setupuser
}

src_compile() {
	append-ldflags $(bindnow-flags)
	# Note that we pass a different directory below due to bugs in the makefile!
	econf --localstatedir=/var || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	einstall localstatedir=${D}/var/nullmailer || die "einstall failed"
	local mailqloc=/usr/bin/mailq
	if use mailwrapper; then
		mv ${D}/usr/sbin/sendmail ${D}/usr/sbin/sendmail.nullmailer
		mailqloc=/usr/bin/mailq.nullmailer
		mv ${D}/usr/bin/mailq ${D}/usr/bin/mailq.nullmailer
		insinto /etc/mail
		doins ${FILESDIR}/mailer.conf
		mailer_install_conf
	fi
	dodoc AUTHORS BUGS COPYING HOWTO INSTALL NEWS README YEAR2000 TODO ChangeLog
	# A small bit of sample config
	insinto /etc/nullmailer
	newins ${FILESDIR}/remotes.sample remotes
	# daemontools stuff
	dodir /var/nullmailer/service{,/log}
	insinto /var/nullmailer/service
	newins scripts/nullmailer.run run
	fperms 700 /var/nullmailer/service/run
	insinto /var/nullmailer/service/log
	newins scripts/nullmailer-log.run run
	fperms 700 /var/nullmailer/service/log/run
	# usablity
	dodir /usr/lib
	dosym /usr/sbin/sendmail usr/lib/sendmail
	# permissions stuff
	keepdir /var/log/nullmailer /var/nullmailer/{tmp,queue}
	fperms 770 /var/log/nullmailer /var/nullmailer/{tmp,queue}
	fowners nullmail:nullmail /usr/sbin/nullmailer-queue ${mailqloc}
	fperms 4711 /usr/sbin/nullmailer-queue ${mailqloc}
	fowners nullmail:nullmail /var/log/nullmailer /var/nullmailer/{tmp,queue,trigger}
	fperms 660 /var/nullmailer/trigger
	msg_mailerconf
	newinitd ${FILESDIR}/init.d-nullmailer nullmailer
}

pkg_config() {
	[ ! -s /etc/nullmailer/me ] && /bin/hostname --fqdn >/etc/nullmailer/me
	[ ! -s /etc/nullmailer/defaultdomain ] && /bin/hostname --domain >/etc/nullmailer/defaultdomain
	msg_svscan
	msg_mailerconf
}

msg_svscan() {
	elog "To start nullmailer at boot you have to enable the /etc/init.d/svscan rc file"
	elog "and create the following link :"
	elog "ln -fs /var/nullmailer/service /service/nullmailer"
	elog "As an alternative, we also provide an init.d script."
	elog
	elog "If the nullmailer service is already running, please restart it now,"
	elog "using 'svc-restart nullmailer' or the init.d script."
	elog
}

msg_mailerconf() {
	use mailwrapper && \
		ewarn "Please ensure you have selected nullmailer in your /etc/mail/mailer.conf"
}

pkg_postinst() {
	setupuser
	# Do this again for good measure
	[ ! -e /var/nullmailer/trigger ] && mkfifo /var/nullmailer/trigger
	chown nullmail:nullmail /var/log/nullmailer /var/nullmailer/{tmp,queue,trigger}
	chmod 770 /var/log/nullmailer /var/nullmailer/{tmp,queue}
	chmod 660 /var/nullmailer/trigger

	elog "To create an initial setup, please do:"
	elog "emerge --config =${CATEGORY}/${PF}"
	msg_svscan
	msg_mailerconf
}
