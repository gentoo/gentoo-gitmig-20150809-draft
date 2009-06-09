# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/fcron/fcron-3.0.4-r2.ebuild,v 1.1 2009/06/09 17:58:51 wschlich Exp $

inherit autotools cron pam eutils

MY_P=${P/_/-}
DESCRIPTION="A command scheduler with extended capabilities over cron and anacron"
HOMEPAGE="http://fcron.free.fr/"
SRC_URI="http://fcron.free.fr/archives/${MY_P}.src.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="debug doc pam selinux"

DEPEND="doc? ( app-text/openjade
		app-text/docbook-sgml
		>=app-text/docbook-dsssl-stylesheets-1.77 )
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

	## patch check_system_crontabs to support "-c /path/to/fcron.conf"
	pushd script &>/dev/null \
		&& epatch "${FILESDIR}"/check_system_crontabs.fcron-config-file.patch \
		&& popd &>/dev/null

	## fix SGML files
	epatch "${FILESDIR}"/${P}-docfix.patch

	eautoreconf || die "autoreconf failed"
}

src_compile() {
	local myconf

	use doc \
		&& myconf="${myconf} --with-dsssl-dir=/usr/share/sgml/stylesheets/dsssl/docbook --with-db2man=/usr/bin/docbook2man"

	[[ -n "${rootuser}" ]] && myconf="${myconf} --with-rootname=${rootuser}"
	[[ -n "${rootgroup}" ]] && myconf="${myconf} --with-rootgroup=${rootgroup}"

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

	use doc && {
		make updatedoc || die "make updatedoc failed"
	}
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
	elog
	elog "fcron has some important differences compared to vixie-cron:"
	elog
	elog "1. fcron stores the crontabs in ${ROOT}var/spool/fcron"
	elog "   instead of ${ROOT}var/spool/cron/crontabs"
	elog
	elog "2. fcron uses a special binary file format for storing the"
	elog "   crontabs in ${ROOT}var/spool/fcron/USERNAME,"
	elog "   but the original plain text version is saved as"
	elog "   ${ROOT}var/spool/fcron/USERNAME.orig for your"
	elog "   reference (and for being edited with fcrontab)."
	elog
	elog "3. fcron does not feature a system crontab in exactly the"
	elog "   same way as vixie-cron does. This version of fcron"
	elog "   features a crontab for a pseudo-user 'systab' for use"
	elog "   as the system crontab. Running a command like"
	elog
	elog "      fcrontab -u systab ${ROOT}etc/crontab"
	elog
	elog "   will write ${ROOT}etc/crontab to the fcron crontabs directory as"
	elog
	elog "      ${ROOT}var/spool/fcron/systab"
	elog
	elog "   Please note that changes to ${ROOT}etc/crontab will not become"
	elog "   active automatically! fcron also does not use the directory"
	elog "   ${ROOT}etc/cron.d by default like vixie-cron does."
	elog "   Fortunately, it's possible to emulate vixie-cron's behavior"
	elog "   with regards to ${ROOT}etc/crontab and ${ROOT}etc/cron.d by using a"
	elog "   little helper script called 'check_system_crontabs'."
	elog "   The file ${ROOT}etc/fcrontab (not ${ROOT}etc/crontab!) has been set up"
	elog "   to run the script once a while to check whether"
	elog "   ${ROOT}etc/fcrontab, ${ROOT}etc/crontab or files in ${ROOT}etc/cron.d/ have"
	elog "   changed since the last generation of the systab and"
	elog "   regenerate it from those three locations as necessary."
	elog "   You should now run 'check_system_crontabs' once to properly"
	elog "   generate an initial systab:"
	elog
	elog "      check_system_crontabs -v -i -f"
	elog
	elog "   The file ${ROOT}etc/fcrontab should only be used to run that"
	elog "   script in order to ensure independence from the standard"
	elog "   system crontab file ${ROOT}etc/crontab."
	elog "   You may of course adjust the schedule for the script"
	elog "   'check_system_crontabs' or any other setting in"
	elog "   ${ROOT}etc/fcrontab as you desire."
	elog
	elog "If you do NOT want to use 'check_system_crontabs', you"
	elog "might still want to activate the use of the well known"
	elog "directories ${ROOT}etc/cron.{hourly|daily|weekly|monthly} by"
	elog "just generating a systab once from ${ROOT}etc/crontab:"
	elog
	elog "   fcrontab -u systab ${ROOT}etc/crontab"
	elog
	elog "Happy fcron'ing!"
	elog

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
