# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailman/mailman-2.1.9-r2.ebuild,v 1.5 2007/11/26 02:24:29 hanno Exp $

inherit eutils python multilib

DESCRIPTION="A python-based mailing list server with an extensive web interface"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://www.list.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	virtual/mta
	virtual/cron
	|| ( www-servers/apache www-servers/lighttpd )"

pkg_setup() {
	INSTALLDIR=${MAILMAN_PREFIX:-"/usr/$(get_libdir)/mailman"}
	VAR_PREFIX=${MAILMAN_VAR_PREFIX:-"/var/lib/mailman"}
	CGIGID=${MAILMAN_CGIGID:-81}
	MAILUSR=${MAILMAN_MAILUSR:-mailman}
	MAILUID=${MAILMAN_MAILUID:-280}
	MAILGRP=${MAILMAN_MAILGRP:-mailman}
	MAILGID=${MAILMAN_MAILGID:-280}

	# Bug #58526: switch to enew{group,user}.
	# need to add mailman here for compile process.
	# Duplicated at pkg_postinst() for binary install.
	enewgroup ${MAILGRP} ${MAILGID}
	enewuser  ${MAILUSR} ${MAILUID} /bin/bash ${INSTALLDIR} mailman -G cron -c "mailman"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/${PN}-2.1.8_rc1-directory-check.patch" || die "patch failed."
}

src_compile() {
	econf --without-permcheck \
		--prefix="${INSTALLDIR}" \
		--with-mail-gid=${MAILGID} \
		--with-cgi-gid=${CGIGID} \
		--with-cgi-ext="${MAILMAN_CGIEXT}" \
		--with-var-prefix="${VAR_PREFIX}" \
		--with-username=${MAILUSR} \
		--with-groupname=${MAILGRP} \
	|| die "configure failed"

	emake || die "make failed"
}

src_install () {
	emake "DESTDIR=${D}" doinstall || die

	insinto /etc/apache2/modules.d
	doins "${FILESDIR}/50_mailman.conf"
	dosed "s:/usr/local/mailman/cgi-bin:${INSTALLDIR}/cgi-bin:g" /etc/apache2/modules.d/50_mailman.conf
	dosed "s:/usr/local/mailman/archives:${VAR_PREFIX}/archives:g" /etc/apache2/modules.d/50_mailman.conf

	dodoc "${FILESDIR}/README.gentoo" ACK* BUGS FAQ NEWS README* TODO UPGRADING INSTALL \
		contrib/README.check_perms_grsecurity contrib/virtusertable contrib/mailman.mc || die "dodoc failed"

	exeinto ${INSTALLDIR}/bin
	doexe build/contrib/*.py contrib/majordomo2mailman.pl contrib/auto \
		contrib/mm-handler* || die

	dodir /etc/mailman
	mv "${D}/${INSTALLDIR}/Mailman/mm_cfg.py" "${D}/etc/mailman"
	dosym /etc/mailman/mm_cfg.py ${INSTALLDIR}/Mailman/mm_cfg.py

	# Save the old config for updates from pre-2.1.9-r2
	# To be removed some distant day
	for i in /var/mailman /home/mailman /usr/local/mailman ${INSTALLDIR}
	do
		if [ -f ${i}/Mailman/mm_cfg.py ] && ! [ -L ${i}/Mailman/mm_cfg.py ]; then
			cp ${i}/Mailman/mm_cfg.py "${D}/etc/mailman/mm_cfg.py"
		fi
	done

	newinitd "${FILESDIR}/mailman.rc" mailman

	keepdir ${VAR_PREFIX}/logs
	keepdir ${VAR_PREFIX}/locks
	keepdir ${VAR_PREFIX}/spam
	keepdir ${VAR_PREFIX}/archives/public
	keepdir ${VAR_PREFIX}/archives/private
	keepdir ${VAR_PREFIX}/lists
	keepdir ${VAR_PREFIX}/qfiles

	chown -R ${MAILUSR}:${MAILGRP} "${D}/${VAR_PREFIX}" "${D}/${INSTALLDIR}" "${D}"/etc/mailman/*
	chmod 2775 "${D}/${INSTALLDIR}" "${D}/${INSTALLDIR}"/templates/* \
		"${D}/${INSTALLDIR}"/messages/* "${D}/${VAR_PREFIX}" "${D}/${VAR_PREFIX}"/{logs,lists,spam,locks,archives/public}
	chmod 2750 "${D}/${VAR_PREFIX}/archives/private"
	chmod 2770 "${D}/${VAR_PREFIX}/qfiles"
	chmod 2755 "${D}/${INSTALLDIR}"/cgi-bin/* "${D}/${INSTALLDIR}/mail/mailman"

}

pkg_postinst() {
	python_mod_optimize ${INSTALLDIR}/bin/ ${INSTALLDIR}/Mailman

	enewgroup ${MAILGRP} ${MAILGID}
	enewuser  ${MAILUSR} ${MAILUID} -1 ${INSTALLDIR} mailman -G cron -c "mailman"
	elog
	elog "Please read /usr/share/doc/${PF}/README.gentoo.gz for additional"
	elog "Setup information, mailman will NOT run unless you follow"
	elog "those instructions!"
	elog

	elog "An example Mailman configuration file for Apache has been installed into:"
	elog "  ${APACHE2_MODULES_CONFDIR}/50_mailman.conf"
	elog
	elog "To enable, you will need to add \"-D MAILMAN\" to"
	elog "/etc/conf.d/apache2."
	elog

	ewarn "Default-Configuration has changed deeply in 2.1.9-r2. You can configure"
	ewarn "mailman with the following variables:"
	ewarn "MAILMAN_PREFIX (default: /usr/$(get_libdir)/mailman)"
	ewarn "MAILMAN_VAR_PREFIX (default: /var/lib/mailman)"
	ewarn "MAILMAN_CGIGID (default: 81)"
	ewarn "MAILMAN_CGIEXT (default: empty)" \
	ewarn "MAILMAN_MAILUSR (default: mailman)"
	ewarn "MAILMAN_MAILUID (default: 280)"
	ewarn "MAILMAN_MAILGRP (default: mailman)"
	ewarn "MAILMAN_MAILGID (default: 280)"
	ewarn
	ewarn "Config file is now symlinked in /etc/mailman, so etc-update works."
	ebeep
}

pkg_postrm() {
	INSTALLDIR=${MAILMAN_PREFIX:-"/usr/$(get_libdir)/mailman"}
	python_mod_cleanup ${INSTALLDIR}/bin ${INSTALLDIR}/Mailman
}
