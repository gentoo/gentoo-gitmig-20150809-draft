# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailman/mailman-2.1.4.ebuild,v 1.4 2004/01/09 02:18:23 mr_bones_ Exp $

IUSE="apache2"

DESCRIPTION="A python-based mailing list server with an extensive web interface"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
RESTRICT="nomirror"
HOMEPAGE="http://www.list.org/"

SLOT="O"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND=">=dev-lang/python-1.5.2
	virtual/mta
	net-www/apache"

INSTALLDIR="/usr/local/mailman"
APACHEGID="81"
MAILGID="280"

pkg_setup() {
	if ! grep -q ^mailman: /etc/group ; then
		groupadd -g 280 mailman || die "problem adding group mailman"
	fi
	if ! grep -q ^mailman: /etc/passwd ; then
		useradd -u 280 -g mailman -G cron -s /bin/bash \
			-d ${INSTALLDIR} -c "mailman" mailman
	fi
	mkdir -p ${INSTALLDIR}
	chown mailman:mailman ${INSTALLDIR}
	chmod 2775 ${INSTALLDIR}
}

src_compile() {
	econf \
		--prefix=${INSTALLDIR} \
		--with-mail-gid=${MAILGID} \
		--with-cgi-gid=${APACHEGID} \
	|| die "configure failed"

	make || die "make failed"
	sed -i -e 's:import japanese:#import japanese:' \
		-e 's:import korean:#import korean:' \
		-e 's:import korean.aliases:#import korean.aliases:' misc/paths.py
}

src_install () {
	ID=${D}${INSTALLDIR}

	dodir ${ID}/logs
	keepdir ${ID}/logs
	dodir ${ID}/locks
	keepdir ${ID}/locks

	dodir ${ID}/spam
	keepdir ${ID}/spam

	chown -R mailman:mailman ${ID}
	chmod 2775 ${ID}

	make prefix=${ID} var_prefix=${ID} doinstall || die

	if [ "`use apache2`" ]; then
		dodir /etc/apache2/conf/modules.d
		insinto /etc/apache2/conf/modules.d
		newins ${FILESDIR}/mailman.conf 50_mailman.conf
	else
		dodir /etc/apache/conf/addon-modules
		insinto /etc/apache/conf/addon-modules
		doins ${FILESDIR}/mailman.conf
	fi

	dodoc ${FILESDIR}/README.gentoo
	dodoc ACK* BUGS FAQ NEWS README* TODO UPGRADING INSTALL
	dodoc contrib/README.check_perms_grsecurity contrib/mm-handler.readme
	dodoc contrib/virtusertable contrib/mailman.mc

	cp contrib/*.py contrib/majordomo2mailman.pl contrib/auto \
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
		cp${ROOT}/usr/local/mailman/Mailman/mm_cfg.py \
			${D}/usr/local/mailman/Mailman/mm_cfg.py
		einfo "Your old config has been saved as mm_cfg.py"
		einfo "A new config has been installed as mm_cfg.py.dist"
	fi

	exeinto /etc/init.d
	newexe ${FILESDIR}/mailman.rc mailman
	}

pkg_postinst() {
	cd ${INSTALLDIR}
	bin/update
	bin/check_perms -f
	einfo ""
	einfo "Please read /usr/share/doc/${PF}/README.gentoo.gz for additional"
	einfo "Setup information, mailman will NOT run unless you follow"
	einfo "those instructions!"
	einfo ""
	if [ ! "`use apache2`" ]; then
		einfo "It appears that you aren't running apache2..."
		einfo "ebuild /var/db/pkg/net-mail/mailman/mailman-2.1.2-r1.ebuild config"
		einfo "to add the mailman hooks to your config"
	fi
}

pkg_config() {
	if [ ! "`use apache2`" ]; then
		einfo "Updating apache config"
		einfo "added: \"Include  conf/addon-modules/mailman.conf\""
		einfo "to ${ROOT}etc/apache/conf/apache.conf"
		echo "Include  conf/addon-modules/mailman.conf" \
			>> ${ROOT}etc/apache/conf/apache.conf
	fi
}
