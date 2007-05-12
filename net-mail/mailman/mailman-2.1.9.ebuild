# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailman/mailman-2.1.9.ebuild,v 1.6 2007/05/12 04:08:33 chtekk Exp $

inherit eutils depend.apache
IUSE="postfix sendmail qmail courier exim xmail"

DESCRIPTION="A python-based mailing list server with an extensive web interface"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://www.list.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc sparc x86"

DEPEND=">=dev-lang/python-2.3
	virtual/mta
	|| ( net-www/apache www-servers/lighttpd )"

INSTALLDIR="/usr/local/mailman"
APACHEGID="81"

if use postfix; then
	MAILGID="280"
elif use sendmail; then
	MAILGID=daemon
elif use qmail; then
	MAILGID="280"
elif use courier; then
	MAILGID=mail
elif use exim; then
	MAILGID=mail
elif use xmail; then
	MAILGID=xmail
else
	MAILGID="280"
fi

S=${WORKDIR}/${P}

pkg_setup() {
	# Bug #58526: switch to enew{group,user}.
	# need to add mailman here for compile process.
	# Duplicated at pkg_postinst() for binary install.
	enewgroup mailman 280
	enewuser mailman 280 /bin/bash ${INSTALLDIR} mailman -G cron -c mailman
	mkdir -p ${INSTALLDIR}
	chown mailman:mailman ${INSTALLDIR}
	chmod 2775 ${INSTALLDIR}
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.1.8_rc1-directory-check.patch || die "patch failed."
}

src_compile() {
	econf \
		--prefix=${INSTALLDIR} \
		--with-mail-gid=${MAILGID} \
		--with-cgi-gid=${APACHEGID} \
	|| die "configure failed"

	make || die "make failed"
}

src_install () {
	ID=${D}${INSTALLDIR}

	make prefix=${ID} var_prefix=${ID} doinstall || die

	keepdir ${INSTALLDIR}/logs
	keepdir ${INSTALLDIR}/locks
	keepdir ${INSTALLDIR}/spam
	keepdir ${INSTALLDIR}/archives/public
	keepdir ${INSTALLDIR}/archives/private
	keepdir ${INSTALLDIR}/lists
	keepdir ${INSTALLDIR}/qfiles

	insinto ${APACHE2_MODULES_CONFDIR}
	doins ${FILESDIR}/50_mailman.conf

	dodoc ${FILESDIR}/README.gentoo
	dodoc ACK* BUGS FAQ NEWS README* TODO UPGRADING INSTALL
	dodoc contrib/README.check_perms_grsecurity contrib/mm-handler.readme
	dodoc contrib/virtusertable contrib/mailman.mc

	cp build/contrib/*.py contrib/majordomo2mailman.pl contrib/auto \
		contrib/mm-handler* ${ID}/bin

	# Save the old config into the new package as CONFIG_PROTECT
	# doesn't work for this package.
	for i in ${ROOT}/var/mailman ${ROOT}/home/mailman \
		${ROOT}/usr/local/mailman ${INSTALLDIR}
	do
		if [ -f ${i}/Mailman/mm_cfg.py ]; then
			cp ${i}/Mailman/mm_cfg.py \
				${ID}/Mailman/mm_cfg.py
			einfo "Your old config has been saved as mm_cfg.py"
			einfo "A new config has been installed as mm_cfg.dist"
		fi
	done

	newinitd ${FILESDIR}/mailman.rc mailman

	chown -R mailman:mailman ${ID}
	chmod 2775 ${ID}
}

pkg_postinst() {
	enewgroup mailman 280
	enewuser mailman 280 -1 ${INSTALLDIR} mailman -G cron -c "mailman"
	cd ${INSTALLDIR}
	bin/update
	einfo "Running \`${INSTALLDIR}/bin/check_perms -f\` *"
	bin/check_perms -f
	einfo ""
	einfo "Please read /usr/share/doc/${PF}/README.gentoo.gz for additional"
	einfo "Setup information, mailman will NOT run unless you follow"
	einfo "those instructions!"
	einfo ""

	einfo "An example Mailman configuration file for Apache has been installed into:"
	einfo "  ${APACHE2_MODULES_CONFDIR}/50_mailman.conf"
	einfo ""
	einfo "To enable, you will need to add \"-D MAILMAN\" to"
	einfo "/etc/conf.d/apache2."
	einfo ""
}
