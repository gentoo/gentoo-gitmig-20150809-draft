# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-nrpe/nagios-nrpe-1.8-r1.ebuild,v 1.4 2004/01/03 13:55:55 aliz Exp $
inherit eutils

DESCRIPTION="Nagios $PV NRPE - Nagios Remote Plugin Executor"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/nrpe-1.8.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~amd64"
IUSE=""
DEPEND=">=net-analyzer/nagios-plugins-1.3.0"
S="${WORKDIR}/nrpe-1.8"

pkg_setup() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /dev/null nagios
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr/nagios \
		--localstatedir=/var/nagios \
		--sysconfdir=/etc/nagios \
		--with-nrpe-user=nagios \
		--with-nrpe-grp=nagios \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake all || die
}

src_install() {
	dodoc LEGAL Changelog README
	insinto /etc/nagios
	newins ${FILESDIR}/nrpe-1.8.cfg nrpe.cfg
	exeinto /usr/nagios/bin
	doexe src/nrpe
	fowners nagios:nagios /usr/nagios/bin/nrpe
	exeinto /usr/nagios/libexec
	doexe src/check_nrpe
	fowners nagios:nagios /usr/nagios/libexec/check_nrpe
	exeinto /etc/init.d
	newexe ${FILESDIR}/nrpe-1.8 nrpe
}
pkg_postinst() {
	einfo
	einfo "If you are using the nrpe daemon, remember to edit"
	einfo "the config file /etc/nagios/nrpe.cfg"
	einfo
}
