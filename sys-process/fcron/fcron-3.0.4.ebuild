# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/fcron/fcron-3.0.4.ebuild,v 1.6 2008/01/25 18:13:19 wschlich Exp $

inherit cron pam eutils

MY_P=${P/_/-}
DESCRIPTION="A command scheduler with extended capabilities over cron and anacron"
HOMEPAGE="http://fcron.free.fr/"
SRC_URI="http://fcron.free.fr/archives/${MY_P}.src.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~mips ppc ~sparc x86 ~x86-fbsd"
IUSE="debug doc pam selinux"

DEPEND="doc? ( >=app-text/docbook-dsssl-stylesheets-1.77 )
	selinux? ( sys-libs/libselinux )
	pam? ( virtual/pam )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup fcron
	enewuser fcron -1 -1 -1 fcron
	rootuser=$(egetent passwd 0 | cut -d ':' -f 1)
	rootgroup=$(egetent group 0 | cut -d ':' -f 1)
	if useq debug; then
		ewarn
		ewarn "WARNING: debug USE flag active!"
		ewarn "The debug USE flag makes fcron start in debug mode"
		ewarn "by default, thus not detaching into background."
		ewarn "This will make your system HANG on bootup if"
		ewarn "fcron is to be started automatically by the"
		ewarn "init system!"
		ewarn
		ebeep 10
		epause 60
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# respect LDFLAGS
	sed -i "s:\(@LIBS@\):\$(LDFLAGS) \1:" Makefile.in || die "sed failed"
}

src_compile() {
	local myconf

	autoconf || die "autoconf failed"

	use doc \
		&& myconf="${myconf} --with-dsssl-dir=/usr/share/sgml/stylesheets/dsssl/docbook"

	[[ -n "${rootuser}" ]] && myconf="${myconf} --with-rootname=${rootuser}"
	[[ -n "${rootgroup}" ]] && myconf="${myconf} --with-rootgroup=${rootgroup}"

	# QA security notice fix; see "[gentoo-core] Heads up changes in suid
	# handing with portage >=51_pre21" for more details.
	append-ldflags $(bindnow-flags)

	econf \
		"$(useq debug || echo --with-cflags=${CFLAGS})" \
		$(use_with debug '' yes) \
		$(use_with pam) \
		$(use_with selinux) \
		--sysconfdir=/etc/fcron \
		--with-username=fcron \
		--with-groupname=fcron \
		--with-piddir=/var/run \
		--with-etcdir=/etc/fcron \
		--with-spooldir=/var/spool/fcron \
		--with-fifodir=/var/run \
		--with-fcrondyn=yes \
		--disable-checks \
		--with-editor=/usr/bin/vi \
		--with-sendmail=/usr/sbin/sendmail \
		--with-shell=/bin/sh \
		${myconf} \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	# cron eclass stuff
	docron fcron -m0755 -o ${rootuser:-root} -g ${rootgroup:-root}
	docrondir /var/spool/fcron -m6770 -o fcron -g fcron
	docrontab fcrontab -m6755 -o fcron -g fcron

	# install fcron tools
	insinto /usr/bin
	# fcronsighup needs to be suid root, because it sends a HUP
	# to the running fcron daemon
	insopts -m6755 -o ${rootuser:-root} -g fcron
	doins fcronsighup
	insopts -m6755 -o fcron -g fcron
	doins fcrondyn

	# /etc stuff
	diropts -m0750 -o ${rootuser:-root} -g fcron
	dodir /etc/fcron
	insinto /etc/fcron
	insopts -m0640 -o ${rootuser:-root} -g fcron
	doins files/fcron.{allow,deny,conf}

	# install PAM files
	newpamd files/fcron.pam fcron
	newpamd files/fcrontab.pam fcrontab

	# install /etc/crontab and /etc/fcrontab
	insopts -m0640 -o ${rootuser:-root} -g ${rootgroup:-root}
	insinto /etc
	doins "${FILESDIR}"/crontab "${FILESDIR}"/fcrontab

	# install init script
	newinitd "${FILESDIR}"/fcron.init fcron

	# install the very handy check_system_crontabs script
	dosbin script/check_system_crontabs

	# doc stuff
	dodoc MANIFEST VERSION
	newdoc files/fcron.conf fcron.conf.sample
	dodoc "${FILESDIR}"/crontab
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
	einfo "fcron has some important differences compared to vixie-cron:"
	einfo
	einfo "1. fcron stores the crontabs in ${ROOT}var/spool/fcron"
	einfo "   instead of ${ROOT}var/spool/cron/crontabs"
	einfo
	einfo "2. fcron uses a special binary file format for storing the"
	einfo "   crontabs in ${ROOT}var/spool/fcron/USERNAME,"
	einfo "   but the original plain text version is saved as"
	einfo "   ${ROOT}var/spool/fcron/USERNAME.orig for your"
	einfo "   reference (and for being edited with fcrontab)."
	einfo
	einfo "3. fcron does not feature a system crontab in exactly the"
	einfo "   same way as vixie-cron does. This version of fcron"
	einfo "   features a crontab for a pseudo-user 'systab' for use"
	einfo "   as the system crontab. Running a command like"
	einfo
	einfo "      fcrontab -u systab ${ROOT}etc/crontab"
	einfo
	einfo "   will write ${ROOT}etc/crontab to the fcron crontabs directory as"
	einfo
	einfo "      ${ROOT}var/spool/fcron/systab"
	einfo
	einfo "   Please note that changes to ${ROOT}etc/crontab will not become"
	einfo "   active automatically! fcron also does not use the directory"
	einfo "   ${ROOT}etc/cron.d by default like vixie-cron does."
	einfo "   Fortunately, it's possible to emulate vixie-cron's behavior"
	einfo "   with regards to ${ROOT}etc/crontab and ${ROOT}etc/cron.d by using a"
	einfo "   little helper script called 'check_system_crontabs'."
	einfo "   The file ${ROOT}etc/fcrontab (not ${ROOT}etc/crontab!) has been set up"
	einfo "   to run the script once a while to check whether"
	einfo "   ${ROOT}etc/fcrontab, ${ROOT}etc/crontab or files in ${ROOT}etc/cron.d/ have"
	einfo "   changed since the last generation of the systab and"
	einfo "   regenerate it from those three locations as necessary."
	einfo "   You should now run 'check_system_crontabs' once to properly"
	einfo "   generate an initial systab:"
	einfo
	einfo "      check_system_crontabs -v -i -f"
	einfo
	einfo "   The file ${ROOT}etc/fcrontab should only be used to run that"
	einfo "   script in order to ensure independence from the standard"
	einfo "   system crontab file ${ROOT}etc/crontab."
	einfo "   You may of course adjust the schedule for the script"
	einfo "   'check_system_crontabs' or any other setting in"
	einfo "   ${ROOT}etc/fcrontab as you desire."
	einfo
	einfo "If you do NOT want to use 'check_system_crontabs', you"
	einfo "might still want to activate the use of the well known"
	einfo "directories ${ROOT}etc/cron.{hourly|daily|weekly|monthly} by"
	einfo "just generating a systab once from ${ROOT}etc/crontab:"
	einfo
	einfo "   fcrontab -u systab ${ROOT}etc/crontab"
	einfo
	einfo "Happy fcron'ing!"
	einfo

	ewarn
	ewarn "Fixing permissions and ownership of ${ROOT}usr/bin/fcron{tab,dyn,sighup}"
	chown fcron:fcron "${ROOT}"usr/bin/fcron{tab,dyn} >&/dev/null
	chown ${rootuser:-root}:fcron "${ROOT}"usr/bin/fcronsighup >&/dev/null
	chmod 6755 "${ROOT}"usr/bin/fcron{tab,dyn,sighup} >&/dev/null
	ewarn "Fixing permissions and ownership of ${ROOT}etc/{fcron,fcrontab,crontab}"
	chown -R ${rootuser:-root}:fcron "${ROOT}"etc/{fcron,fcrontab,crontab} >&/dev/null
	chmod -R g+rX,o= "${ROOT}"etc/fcron "${ROOT}"etc/{fcron,fcrontab,crontab} >&/dev/null
	ewarn

	ewarn
	ewarn "WARNING: fcron now uses a dedicated user and group"
	ewarn "'fcron' for the suid/sgid programs/files instead of"
	ewarn "the user and group 'cron' that were previously used."
	ewarn
	ewarn "fcron usage can now only be restricted by adding users"
	ewarn "to the following files instead of to the group 'cron':"
	ewarn
	ewarn "   ${ROOT}etc/fcron/fcron.allow"
	ewarn "   ${ROOT}etc/fcron/fcron.deny"
	ewarn
	ebeep 10
	epause 10

	if ls -1 "${ROOT}"var/spool/cron/fcrontabs/* >&/dev/null; then
		ewarn
		ewarn "WARNING: fcron now uses a dedicated fcron-specific"
		ewarn "spooldir ${ROOT}var/spool/fcron instead of the commonly"
		ewarn "used ${ROOT}var/spool/cron for several reasons."
		ewarn
		ewarn "Copying over existing crontabs from ${ROOT}var/spool/cron/fcrontabs"
		cp "${ROOT}"var/spool/cron/fcrontabs/* "${ROOT}"var/spool/fcron/ >&/dev/null \
			|| die "failed to migrate existing crontabs"
		ewarn "You should now remove ${ROOT}var/spool/cron/fcrontabs!"
		ewarn
		ewarn "Fixing permissions and ownership of ${ROOT}var/spool/fcron"
		chown root:root "${ROOT}"var/spool/fcron/* >&/dev/null
		chmod 0600 "${ROOT}"var/spool/fcron/* >&/dev/null
		chown fcron:fcron "${ROOT}"var/spool/fcron/*.orig >&/dev/null
		chmod 0640 "${ROOT}"var/spool/fcron/*.orig >&/dev/null
		ewarn
		ewarn "*** YOU SHOULD IMMEDIATELY UPDATE THE"
		ewarn "*** fcrontabs ENTRY IN ${ROOT}etc/fcron/fcron.conf"
		ewarn "*** AND RESTART YOUR FCRON DAEMON!"
		ebeep 20
		epause 10
	fi
}
