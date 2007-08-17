# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-nsca/nagios-nsca-2.6.ebuild,v 1.7 2007/08/17 01:15:55 dertobi123 Exp $

DESCRIPTION="Nagios NSCA  - Nagios Service Check Acceptor"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/nsca-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=net-analyzer/nagios-plugins-1.3.1
	>=dev-libs/libmcrypt-2.5.1-r4"
S="${WORKDIR}/nsca-${PV}"

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
	emake all || die "emake failed"
}

src_install() {
	dodoc LEGAL Changelog README SECURITY
	insinto /etc/nagios
	doins "${S}"/sample-config/nsca.cfg
	doins "${S}"/sample-config/send_nsca.cfg
	exeinto /usr/nagios/bin
	doexe src/nsca
	fowners nagios:nagios /usr/nagios/bin/nsca
	exeinto /usr/nagios/libexec
	doexe src/send_nsca
	fowners nagios:nagios /usr/nagios/libexec/send_nsca
	newinitd "${FILESDIR}"/nsca nsca
}
pkg_postinst() {
	einfo
	einfo "If you are using the nsca daemon, remember to edit"
	einfo "the config file /etc/nagios/nsca.cfg"
	einfo
}
