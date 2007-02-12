# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/fcron/fcron-3.0.2.ebuild,v 1.2 2007/02/12 00:00:33 wschlich Exp $

inherit cron pam eutils

DESCRIPTION="A command scheduler with extended capabilities over cron and anacron"
HOMEPAGE="http://fcron.free.fr/"
SRC_URI="http://fcron.free.fr/archives/${P}.src.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="debug doc pam selinux"

DEPEND="app-editors/nano
	doc? ( >=app-text/docbook-dsssl-stylesheets-1.77 )
	selinux? ( sys-libs/libselinux )
	pam? ( virtual/pam )"

pkg_setup() {
	ROOTUSER=$(egetent passwd 0 | cut -d ':' -f 1)
	ROOTGROUP=$(egetent group 0 | cut -d ':' -f 1)
	if useq debug; then
		ewarn
		ewarn "WARNING: debug USE flag active!"
		ewarn "The debug USE flag makes fcron start in debug mode"
		ewarn "by default, thus not detaching into background."
		ewarn "This will make your system HANG on bootup if"
		ewarn "fcron is to be started automatically by the"
		ewarn "init system!"
		ewarn
		ebeep 5
		epause 60
	fi
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
		--with-editor=/bin/nano \
		--with-shell=/bin/sh \
		${myconf} \
		|| die "Configure problem"

	emake || die "Compile problem"
}

src_install() {
	# cron eclass stuff
	docrondir /var/spool/cron/fcrontabs -m0770 -o cron -g cron
	docron fcron -m0110 -o ${ROOTUSER:-root} -g ${ROOTGROUP:-root}
	docrontab fcrontab -m6110 -o cron -g cron

	# install fcron tools
	insinto /usr/bin
	insopts -o ${ROOTUSER:-root} -g cron -m6110 ; doins fcronsighup
	insopts -o cron -g cron -m6110 ; doins fcrondyn

	# /etc stuff
	insinto /etc/fcron
	insopts -m 640 -o ${ROOTUSER:-root} -g cron
	doins files/fcron.{allow,deny,conf}
	dosed 's:^\(fcrontabs.*=.*\)$:\1/fcrontabs:' /etc/fcron/fcron.conf \
		|| die "dosed fcron.conf failed"

	# install PAM files
	newpamd files/fcron.pam fcron
	newpamd files/fcrontab.pam fcrontab

	# install /etc/crontab and /etc/fcrontab
	insinto /etc
	doins ${FILESDIR}/crontab ${FILESDIR}/fcrontab

	# install init script
	newinitd ${FILESDIR}/fcron.init fcron || die "newinitd failed"

	# install the very handy check_system_crontabs script
	mv script/check_system_crontabs script/check_system_crontabs.orig
	sed -e 's:^FCRONTABS_DIR=.*$:FCRONTABS_DIR=/var/spool/cron/fcrontabs:' \
		script/check_system_crontabs.orig > script/check_system_crontabs
	dosbin script/check_system_crontabs

	# doc stuff
	dodoc MANIFEST VERSION
	newdoc files/fcron.conf fcron.conf.sample
	dodoc ${FILESDIR}/crontab
	dodoc doc/en/txt/{readme,thanks,faq,todo,relnotes,changes}.txt
	rm -f doc/en/man/*.3 # ugly hack for bitstring.3 manpage
	doman doc/en/man/*.[0-9]
	use doc && dohtml doc/en/HTML/*.html

	# localized docs
	local LANGUAGES=$(sed -n 's:LANGUAGES =::p' doc/Makefile)
	LANGUAGES="${LANGUAGES/en/}"
	local lang
	for lang in ${LANGUAGES}; do
		hasq ${lang} ${LINGUAS} || continue
		rm -f doc/${lang}/man/*.3 # ugly hack for bitstring.3 manpage
		doman -i18n=${lang} doc/${lang}/man/*.[0-9]
		use doc && docinto html/${lang} && dohtml doc/${lang}/HTML/*.html
	done
}

pkg_postinst() {
	einfo
	einfo "Each user who uses fcron should be added to the cron group"
	einfo "in /etc/group and also be added to /etc/fcron/fcron.allow"
	einfo
	einfo "fcron has some important differences compared to vixie-cron:"
	einfo
	einfo "1. fcron stores the crontabs in /var/spool/cron/fcrontabs"
	einfo
	einfo "2. fcron uses a special binary file format for storing the"
	einfo "   crontabs in /var/spool/cron/fcrontabs/USERNAME,"
	einfo "   but the original plain text version is saved as"
	einfo "   /var/spool/cron/fcrontabs/USERNAME.orig for your reference."
	einfo
	einfo "3. fcron does not feature a system crontab in exactly the"
	einfo "   same way as vixie-cron does. This version of fcron"
	einfo "   features a crontab for a pseudo-user 'systab' for use"
	einfo "   as the system crontab. Running a command like"
	einfo
	einfo "      fcrontab -u systab /etc/crontab"
	einfo
	einfo "   will write /etc/crontab to the fcron crontabs directory as"
	einfo
	einfo "      /var/spool/cron/fcrontabs/systab"
	einfo
	einfo "   Please note that changes to /etc/crontab will not become"
	einfo "   active automatically! fcron also does not use the directory"
	einfo "   /etc/cron.d by default like vixie-cron does."
	einfo "   Fortunately, it's possible to emulate vixie-cron's behavior"
	einfo "   with regards to /etc/crontab and /etc/cron.d by using a"
	einfo "   little helper script called 'check_system_crontabs'."
	einfo "   The file /etc/fcrontab (not /etc/crontab!) has been set up"
	einfo "   to run the script once a while to check whether"
	einfo "   /etc/fcrontab, /etc/crontab or files in /etc/cron.d/ have"
	einfo "   changed since the last generation of the systab and"
	einfo "   regenerate it from those three locations as necessary."
	einfo "   You should run 'check_system_crontabs' once now to properly"
	einfo "   generate an initial systab:"
	einfo
	einfo "      check_system_crontabs -v -i -f"
	einfo
	einfo "   The file /etc/fcrontab should only be used to run that"
	einfo "   script in order to ensure independence from the standard"
	einfo "   system crontab file /etc/crontab."
	einfo "   You may of course adjust the schedule for the script"
	einfo "   'check_system_crontabs' or any other setting in"
	einfo "   /etc/fcrontab as you desire."
	einfo
	einfo "If you do NOT want to use 'check_system_crontabs', you"
	einfo "might still want to activate the use of the well known"
	einfo "directories /etc/cron.{hourly|daily|weekly|monthly} by"
	einfo "just generating a systab once from /etc/crontab:"
	einfo
	einfo "    fcrontab -u systab /etc/crontab"
	einfo
	einfo "Happy fcron'ing!"
	einfo
}
