# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/fcron/fcron-3.0.1.ebuild,v 1.1 2006/02/22 02:45:02 ka0ttic Exp $

inherit cron pam eutils

DESCRIPTION="A command scheduler with extended capabilities over cron and anacron"
HOMEPAGE="http://fcron.free.fr/"
SRC_URI="http://fcron.free.fr/archives/${P}.src.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~hppa ~amd64"
IUSE="debug doc pam selinux"

DEPEND="virtual/editor
	doc? ( >=app-text/docbook-dsssl-stylesheets-1.77 )
	selinux? ( sys-libs/libselinux )
	pam? ( >=sys-libs/pam-0.77 )"

pkg_setup() {
	# sudo unsets EDITOR
	if [[ -z "${EDITOR}" ]] ; then
		eerror "EDITOR seems to be unset. If you use sudo, it may be the cause."
		eerror "Try using 'sudo env EDITOR=\${EDITOR} emerge' instead."
		die "Please set the EDITOR env variable to the path of a valid executable."
	fi

	# bug #65263
	# fcron's ./configure complains if EDITOR is not set to an absolute path,
	# so try to set it to the abs path if it isn't
	if [[ "${EDITOR}" != */* ]] ; then
		einfo "Attempting to deduce absolute path of ${EDITOR}"
		EDITOR=$(which ${EDITOR} 2>/dev/null)
		[[ -x "${EDITOR}" ]] || \
			die "Please set the EDITOR env variable to the path of a valid executable."
	fi

	ROOTUSER=$(egetent passwd 0 | cut -d':' -f1)
	ROOTGROUP=$(egetent group 0 | cut -d':' -f1)
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.0.0-configure.diff
	# respect LDFLAGS
	sed -i "s:\(@LIBS@\):\$(LDFLAGS) \1:" Makefile.in || die "sed failed"
}

src_compile() {
	local myconf

	autoconf || die "autoconf failed"

	use doc && \
		myconf="${myconf} --with-dsssl-dir=/usr/share/sgml/stylesheets/dsssl/docbook"

	[[ -n "${ROOTUSER}" ]] && myconf="${myconf} --with-rootname=${ROOTUSER}"
	[[ -n "${ROOTGROUP}" ]] && myconf="${myconf} --with-rootgroup=${ROOTGROUP}"

	# QA security notice fix; see "[gentoo-core] Heads up changes in suid
	# handing with portage >=51_pre21" for more details.
	append-ldflags $(bindnow-flags)

	econf \
		$(use_with pam) \
		$(use_with selinux) \
		$(use_with debug) \
		--with-username=cron \
		--with-groupname=cron \
		--with-piddir=/var/run \
		--with-etcdir=/etc/fcron \
		--with-spooldir=/var/spool/cron \
		--with-fifodir=/var/run \
		--with-sendmail=/usr/sbin/sendmail \
		--with-fcrondyn=yes \
		--with-editor=${EDITOR} \
		--with-shell=/bin/sh \
		${myconf} \
		|| die "Configure problem"

	emake || die "Compile problem"
}

src_install() {
	docrondir /var/spool/cron/fcrontabs -m0770 -o cron -g cron
	docron fcron -m0110 -o ${ROOTUSER:-root} -g ${ROOTGROUP:-root}
	docrontab fcrontab -m6110 -o cron -g cron

	insinto /usr/bin
	insopts -o ${ROOTUSER:-root} -g cron -m6110 ; doins fcronsighup
	insopts -o cron -g cron -m6110 ; doins fcrondyn

	# /etc stuff
	insinto /etc/fcron
	insopts -m 640 -o ${ROOTUSER:-root} -g cron
	doins files/fcron.{allow,deny,conf}
	dosed 's:^\(fcrontabs.*=.*\)$:\1/fcrontabs:' /etc/fcron/fcron.conf \
		|| die "dosed fcron.conf failed"

	newpamd files/fcron.pam fcron
	newpamd files/fcrontab.pam fcrontab

	insinto /etc
	doins ${FILESDIR}/crontab

	newinitd ${FILESDIR}/fcron.rc6 fcron || die "newinitd failed"

	# doc stuff
	dodoc MANIFEST VERSION doc/txt/*.txt script/check_system_crontabs
	newdoc files/fcron.conf fcron.conf.sample
	use doc && dohtml doc/HTML/*.html
	dodoc ${FILESDIR}/crontab

	doman doc/man/*
}

pkg_postinst() {
	einfo "Each user who uses fcron should be added to the cron group"
	einfo "in /etc/group and also be added in /etc/fcron/fcron.allow"
	einfo
	einfo "It is possible to emulate vixie-cron's behavior with regards to /etc/crontab"
	einfo "and /etc/cron.d.  To do so, read the directions provided in the script,"
	einfo "/usr/share/doc/${PF}/check_system_crontabs.gz."
	cron_pkg_postinst
}
