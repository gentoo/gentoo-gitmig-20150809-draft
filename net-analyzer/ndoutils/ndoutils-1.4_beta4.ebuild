# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ndoutils/ndoutils-1.4_beta4.ebuild,v 1.2 2007/08/23 14:19:13 dertobi123 Exp $

inherit eutils

MY_P=${P/_beta/b}

DESCRIPTION="Nagios addon to store Nagios data in a MySQL database"
HOMEPAGE="http://www.nagios.org"
SRC_URI="mirror://sourceforge/nagios/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-db/mysql"
RDEPEND="${DEPEND}
	>=net-analyzer/nagios-core-2.7"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /var/nagios/home nagios
}

src_compile() {
	econf \
		--prefix=/usr/nagios \
		--sysconfdir=/etc/nagios \
		--enable-mysql \
		--disable-pgsql || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	dodir /usr/nagios/bin
	cp ${S}/src/{file2sock,log2ndo,ndo2db-2x,ndomod-2x.o,sockdebug} ${D}/usr/nagios/bin

	dodir /usr/nagios/share/
	cp -R ${S}/db ${D}/usr/nagios/share

	chown -R root:nagios ${D}/usr/nagios || die "Failed chown of ${D}/usr/nagios"
	chmod 750 ${D}/usr/nagios/bin/{file2sock,log2ndo,ndo2db-2x,ndomod-2x.o,sockdebug} || "Failed chmod"

	dodoc README REQUIREMENTS TODO UPGRADING Changelog "docs/NDOUTILS DB Model.pdf" "docs/NDOUtils Documentation.pdf"

cat << EOF > "${T}"/55-ndoutils-revdep
SEARCH_DIRS="/usr/nagios/bin"
EOF

	sed -i s:socket_name=/usr/local/nagios/var/ndo.sock:socket_name=/var/nagios/ndo.sock:g ${S}/config/ndo2db.cfg

	insinto /etc/revdep-rebuild
	doins "${T}"/55-ndoutils-revdep

	insinto /etc/nagios
	doins ${S}/config/ndo2db.cfg
	doins ${S}/config/ndomod.cfg

	newinitd ${FILESDIR}/ndo2db.init ndo2db
}

pkg_postinst() {
	elog "To include NDO in your Nagios setup you'll need to activate the NDO broker module"
	elog "in /etc/nagios/nagios.cfg:"
	elog "\tbroker_module=/usr/nagios/bin/ndomod-2x.o config_file=/etc/nagios/ndomod.cfg"
}
