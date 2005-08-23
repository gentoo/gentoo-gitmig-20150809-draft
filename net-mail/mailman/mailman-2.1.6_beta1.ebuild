# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailman/mailman-2.1.6_beta1.ebuild,v 1.3 2005/08/23 13:38:41 ticho Exp $

inherit eutils depend.apache
IUSE="apache2"

MY_PV=${PV/_beta/b}

DESCRIPTION="A python-based mailing list server with an extensive web interface"
#SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tgz"
SRC_URI="http://www.list.org/${PN}-${MY_PV}.tgz"
HOMEPAGE="http://www.list.org/"

SLOT="O"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

DEPEND=">=dev-lang/python-2.3
	virtual/mta
	net-www/apache"

INSTALLDIR="/usr/local/mailman"
APACHEGID="81"
MAILGID="280"

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
	# Bug #77524. remove with version bump.
	#epatch ${FILESDIR}/${P}-driver.cvs.patch || die "patch failed."
	#epatch ${FILESDIR}/${P}-true_path.patch || die "patch failed."
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
		dodir /etc/apache2/conf/modules.d
		#dodir ${APACHE2_MODULES_CONFDIR}
		insinto /etc/apache2/conf/modules.d
		#insinto ${APACHE2_MODULES_CONFDIR}
		newins ${FILESDIR}/mailman.conf 50_mailman.conf
	else
		dodir /etc/apache/conf/addon-modules
		#dodir ${APACHE1_MODULES_CONFDIR}
		insinto /etc/apache/conf/addon-modules
		#insinto ${APACHE1_MODULES_CONFDIR}
		doins ${FILESDIR}/mailman.conf
	fi

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

	# per vericgar's advise
	# we dont need to do this anymore with the new apache revision.
	# will remove these when the new apache unmasked.
	if ! use apache2; then
		einfo "It appears that you aren't running apache2..."
		einfo "ebuild /var/db/pkg/net-mail/${PN}/${PF}.ebuild config"
		einfo "to add the mailman hooks to your config"
	fi
}

pkg_config() {
	if ! use apache2; then
		einfo "Updating apache config"
		einfo "added: \"Include  conf/addon-modules/mailman.conf\""
		einfo "to ${ROOT}/etc/apache/conf/apache.conf"
		echo "Include  conf/addon-modules/mailman.conf" \
			>> ${ROOT}/etc/apache/conf/apache.conf
	fi
}
