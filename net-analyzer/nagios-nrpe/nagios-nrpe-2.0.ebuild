# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-nrpe/nagios-nrpe-2.0.ebuild,v 1.7 2004/11/30 22:18:55 swegener Exp $

inherit eutils

DESCRIPTION="Nagios $PV NRPE - Nagios Remote Plugin Executor"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/nrpe-${PV}.tar.gz"

RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 ~ppc sparc ~amd64"

IUSE="ssl"
DEPEND=">=net-analyzer/nagios-plugins-1.3.0
	ssl? ( dev-libs/openssl )"
S="${WORKDIR}/nrpe-${PV}"

pkg_setup() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /dev/null nagios
}

src_compile() {
	local myconf

	myconf="${myconf} `use_enable ssl`"

	./configure ${myconf} \
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
	dodoc LEGAL Changelog README SECURITY README.SSL

	insinto /etc/nagios
	newins ${FILESDIR}/nrpe-${PV}.cfg nrpe.cfg

	exeinto /usr/nagios/bin
	doexe src/nrpe

	fowners nagios:nagios /usr/nagios/bin/nrpe

	exeinto /usr/nagios/libexec
	doexe src/check_nrpe

	fowners nagios:nagios /usr/nagios/libexec/check_nrpe

	exeinto /etc/init.d
	newexe ${FILESDIR}/nrpe-${PV} nrpe
}
pkg_postinst() {
	einfo
	einfo "If you are using the nrpe daemon, remember to edit"
	einfo "the config file /etc/nagios/nrpe.cfg"
	einfo
}
