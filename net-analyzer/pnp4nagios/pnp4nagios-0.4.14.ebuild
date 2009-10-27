# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pnp4nagios/pnp4nagios-0.4.14.ebuild,v 1.1 2009/10/27 19:40:42 dertobi123 Exp $

EAPI="2"

MY_P=pnp-${PV}

DESCRIPTION="A performance data analyzer for nagios"
HOMEPAGE="http://www.pnp4nagios.org"

SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND=">=dev-lang/php-4.3[gd-external,pcre,xml,zlib]
	>=net-analyzer/rrdtool-1.2
	net-analyzer/nagios-core"
RDEPEND="${DEPEND}
	virtual/perl-Getopt-Long
	virtual/perl-Time-HiRes"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf \
		--sysconfdir=/etc/pnp \
		--datarootdir=/usr/share/pnp \
		--with-perfdata-dir=/var/nagios/perfdata \
		--with-perfdata-spool-dir=/var/spool/pnp  || die "econf failed"
}

src_compile() {
	emake all || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install install-config || die "emake install failed"
	doinitd "${FILESDIR}/npcd"
}

pkg_postinst() {
	elog "To include the pnp webinterface into your Nagios setup you could use"
	elog "an Alias in you Apache configuration as follows:"

	elog "\tAlias /nagios/pnp       /usr/share/pnp/"
	elog "\t<Directory "/usr/share/pnp">"
	elog "\t\tAllowOverride AuthConfig"
	elog "\t\tOrder allow,deny"
	elog "\t\tAllow from all"
	elog "\t</Directory>"
}
