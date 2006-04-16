# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailman/mailman-2.1.8_rc1.ebuild,v 1.4 2006/04/16 00:15:14 weeve Exp $

inherit eutils depend.apache
IUSE="apache2 postfix sendmail qmail courier exim xmail"

MY_PV=${PV/_rc/rc}

DESCRIPTION="A python-based mailing list server with an extensive web interface"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tgz"
HOMEPAGE="http://www.list.org/"

SLOT="O"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc sparc ~x86"

DEPEND=">=dev-lang/python-2.3
	virtual/mta
	net-www/apache"

INSTALLDIR="/usr/local/mailman"
APACHEGID="81"

if use postfix; then
	MAILGID="280"
elif use sendmail; then
	MAILGID=daemon
elif use qmail; then
	MAILGID=qmail
elif use courier; then
	MAILGID=mail
elif use exim; then
	MAILGID=mail
elif use xmail; then
	MAILGID=xmail
else
	MAILGID="280"
fi

S=${WORKDIR}/${PN}-${MY_PV}

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
	unpack ${A} && cd "${S}"
	epatch ${FILESDIR}/${P}-directory-check.patch || die "patch failed."
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

	if use apache2; then
		insinto ${APACHE2_MODULES_CONFDIR}
	else
		insinto ${APACHE1_MODULES_CONFDIR}
	fi
	newins ${FILESDIR}/mailman.conf 50_mailman.conf

	dodoc ${FILESDIR}/README.gentoo
	dodoc ACK* BUGS FAQ NEWS README* TODO UPGRADING INSTALL
	dodoc contrib/README.check_perms_grsecurity contrib/mm-handler.readme
	dodoc contrib/virtusertable contrib/mailman.mc

	cp build/contrib/*.py contrib/majordomo2mailman.pl contrib/auto \
		contrib/mm-handler* ${D}/usr/local/mailman/bin

	# Save the old config into the new package as CONFIG_PROTECT
	# doesn't work for this package.
	if [ -f ${ROOT}/var/mailman/Mailman/mm_cfg.py ]; then
		cp ${ROOT}/var/mailman/Mailman/mm_cfg.py \
			${D}/usr/local/mailman/Mailman/mm_cfg.py
		einfo "Your old config has been saved as mm_cfg.py"
		einfo "A new config has been installed as mm_cfg.dist"
	fi
	if [ -f ${ROOT}/home/mailman/Mailman/mm_cfg.py ]; then
		cp ${ROOT}/home/mailman/Mailman/mm_cfg.py \
			${D}/usr/local/mailman/Mailman/mm_cfg.py
		einfo "Your old config has been saved as mm_cfg.py"
		einfo "A new config has been installed as mm_cfg.py.dist"
	fi
	if [ -f ${ROOT}/usr/local/mailman/Mailman/mm_cfg.py ]; then
		cp ${ROOT}/usr/local/mailman/Mailman/mm_cfg.py \
			${D}/usr/local/mailman/Mailman/mm_cfg.py
		einfo "Your old config has been saved as mm_cfg.py"
		einfo "A new config has been installed as mm_cfg.py.dist"
	fi

	exeinto /etc/init.d
	newexe ${FILESDIR}/mailman.rc mailman

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
	use apache2 && einfo "  ${APACHE2_MODULES_CONFDIR}/50_mailman.conf"
	use apache2 || einfo "  ${APACHE1_MODULES_CONFDIR}/50_mailman.conf"
	einfo ""
	einfo "To enable, you will need to add \"-D MAILMAN\" to"
	use apache2 && einfo "/etc/conf.d/apache2."
	use apache2 || einfo "/etc/conf.d/apache."
	einfo ""
}
