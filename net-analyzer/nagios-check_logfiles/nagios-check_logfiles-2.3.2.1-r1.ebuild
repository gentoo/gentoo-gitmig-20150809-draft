# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-check_logfiles/nagios-check_logfiles-2.3.2.1-r1.ebuild,v 1.7 2009/03/18 22:18:37 ranger Exp $

inherit eutils
DESCRIPTION="A nagios plugin for checking logfiles"
HOMEPAGE="http://www.consol.com/opensource/nagios/check-logfiles"

MY_P=${P/nagios-/}

SRC_URI="http://www.consol.com/fileadmin/opensource/Nagios/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~alpha amd64 ~ppc ppc64 ~sparc x86"
IUSE=""

DEPEND=">=net-analyzer/nagios-plugins-1.4.13-r1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf \
		--prefix=/usr \
		--libexecdir=/usr/$(get_libdir)/nagios/plugins \
		--sysconfdir=/etc/nagios || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
