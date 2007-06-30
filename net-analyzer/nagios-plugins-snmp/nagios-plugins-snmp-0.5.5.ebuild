# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-plugins-snmp/nagios-plugins-snmp-0.5.5.ebuild,v 1.3 2007/06/30 16:37:45 dertobi123 Exp $

inherit eutils

DESCRIPTION="Additional Nagios plugins for monitoring SNMP capable devices"
HOMEPAGE="http://nagios.manubulon.com"
SRC_URI="http://nagios.manubulon.com/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-analyzer/net-snmp"
RDEPEND="${DEPEND}"

S=${WORKDIR}/nagios-plugins-snmp

pkg_setup() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /var/nagios/home nagios
}

src_compile() {
	econf \
		--prefix=/usr/nagios \
		--sysconfdir=/etc/nagios || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	chown -R root:nagios ${D}/usr/nagios/libexec || die "Failed Chown of ${D}usr/nagios/libexec"
	chmod -R o-rwx ${D}/usr/nagios/libexec || "Failed Chmod of ${D}usr/nagios/libexec"

	dodoc README NEWS AUTHORS

cat << EOF > "${T}"/55-nagios-plugins-snmp-revdep
SEARCH_DIRS="/usr/nagios/libexec"
EOF

	insinto /etc/revdep-rebuild
	doins "${T}"/55-nagios-plugins-snmp-revdep
}
