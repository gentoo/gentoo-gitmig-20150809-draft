# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailman/mailman-2.1.1-r1.ebuild,v 1.1 2003/04/18 22:44:25 mholzer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU Mailman, the mailing list server with webinterface"
SRC_URI="mirror://gnu/${PN}/${P}.tgz"
HOMEPAGE="http://www.list.org/"

SLOT="O"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc "

DEPEND=">=dev-lang/python-1.5.2
	virtual/mta
	net-www/apache"

INSTALLDIR="/var/mailman"
APACHEGID="81"
MAILGID="65534"

pkg_setup() {
        if ! grep -q ^mailman: /etc/group ; then
                groupadd -g 280 mailman || die "problem adding group mailman"
        fi
        if ! grep -q ^mailman: /etc/passwd ; then
                useradd -u 280 -g mailman -G cron -s /bin/bash \
					-d ${INSTALLDIR} -c "mailman" mailman
        fi
	mkdir -p ${INSTALLDIR}
	chown mailman.mailman ${INSTALLDIR}
	chmod 2775 ${INSTALLDIR}
}

src_compile() {
        cd ${S}
        ./configure \
                --prefix=${INSTALLDIR} \
                --with-mail-gid=${MAILGID} \
                --with-cgi-gid=${APACHEGID}
        make || die
}

src_install () {
	ID=${D}${INSTALLDIR}
        cd ${S}
        mkdir -p ${ID}
        chown -R mailman.mailman ${ID}
        chmod 2775 ${ID}
        make prefix=${ID} var_prefix=${ID} doinstall || die
	insinto /etc/apache/conf/addon-modules
	doins ${FILESDIR}/mailman.conf
	
	dodoc ${FILESDIR}/README.gentoo
	dodoc ACK* BUGS FAQ NEWS README* TODO UPGRADING
	dodoc contrib/README.check_perms_grsecurity contrib/mm-handler.readme
	dodoc contrib/virtusertable contrib/mailman.mc

	cp contrib/*.py contrib/majordomo2mailman.pl contrib/auto \
		contrib/mm-handler* ${D}/var/mailman/bin

	# Save the old config into the new package as CONFIG_PROTECT
	# doesn't work for this package.
	if [ -f ${ROOT}/var/mailman/Mailman/mm_cfg.py ]; then
		rm ${D}/var/mailman/Mailman/mm_cfg.py
		cp ${ROOT}/var/mailman/Mailman/mm_cfg.py \
			${D}/var/mailman/Mailman/mm_cfg.py
		einfo "Your old config has been saved."
		einfo "A new config has been installed as mm_cfg.py.dist"
	fi

	exeinto /etc/init.d
	newexe ${FILESDIR}/mailman.rc mailman
	}

pkg_postinst() {
	cd ${INSTALLDIR}
	bin/update
	bin/check_perms -f
	einfo
	einfo "Please read /usr/share/doc/${PF}/README.gentoo.gz for additional"
	einfo "Setup information, mailman will NOT run unless you follow"
	einfo "those instructions!"
}

pkg_config() {
	einfo "Updating apache config"
	einfo "added: \"Include  conf/addon-modules/mailman.conf\""
	einfo "to ${ROOT}/etc/apache/conf/apache.conf"
        echo "Include  conf/addon-modules/mailman.conf" \
		>> ${ROOT}/etc/apache/conf/apache.conf
}
