# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailman/mailman-2.0.12.ebuild,v 1.4 2002/08/14 12:05:25 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU Mailman, the mailing list server with webinterface"
SRC_URI="ftp://ftp.gnu.org/gnu/mailman/mailman-2.0.12.tgz"
HOMEPAGE="http://www.list.org/"
DEPEND=">=dev-lang/python-1.5.2
        virtual/mta
        net-www/apache"

SLOT="O"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

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
}

pkg_postinst() {
	cd ${INSTALLDIR}
	bin/update
	bin/check_perms -f
		einfo
		einfo "Please read /usr/share/doc/${P}/README.gentoo for additional"
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
