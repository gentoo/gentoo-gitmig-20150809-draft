# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pnp4nagios/pnp4nagios-0.4.7.ebuild,v 1.1 2008/04/12 18:42:37 caleb Exp $

MY_P=pnp-${PV}

DESCRIPTION="A performance data analyzer for nagios"
HOMEPAGE="http://www.pnp4nagios.org"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=dev-lang/php-4.3
	>=net-analyzer/rrdtool-1.2
	net-analyzer/nagios-core"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf --prefix=/usr/nagios --datadir=/usr/nagios/share/pnp \
		--sysconfdir=/usr/nagios/etc/pnp \
		--with-perfdata-dir=/usr/nagios/share/perfdata || die "econf failed"
	emake all || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" fullinstall || die "emake install failed"
}
