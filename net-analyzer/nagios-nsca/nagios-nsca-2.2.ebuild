# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-nsca/nagios-nsca-2.2.ebuild,v 1.4 2003/09/05 23:40:09 msterret Exp $
DESCRIPTION="Nagios $PV NSCA  - Nagios Service Check Acceptor"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/nsca-2.2.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""
DEPEND=">=net-analyzer/nagios-plugins-1.3.0_beta2
		>=libmcrypt-2.5.1-r4"
S="${WORKDIR}/nsca-2.2"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr/nagios \
		--localstatedir=/var/nagios \
		--sysconfdir=/etc/nagios \
		--with-nsca-user=nagios \
		--with-nsca-grp=nagios \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake all || die
}

src_install() {
	dodoc LEGAL Changelog README SECURITY
	insinto /etc/nagios
	doins ${FILESDIR}/nsca.cfg
	doins ${FILESDIR}/send_nsca.cfg
	exeinto /usr/nagios/bin
	doexe src/nsca
	fowners nagios:nagios /usr/nagios/bin/nsca
	exeinto /usr/nagios/libexec
	doexe src/send_nsca
	fowners nagios:nagios /usr/nagios/libexec/send_nsca
	exeinto /etc/init.d
	doexe ${FILESDIR}/nsca
}
pkg_postinst() {
	einfo
	einfo "If you are using the nsca daemon, remember to edit"
	einfo "the config file /etc/nagios/nsca.cfg"
	einfo
}
