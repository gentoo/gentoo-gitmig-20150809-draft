# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/portmon/portmon-1.9.ebuild,v 1.4 2004/03/22 12:00:18 mboman Exp $

DESCRIPTION="Portmon is a netwok service monitoring daemon."
SRC_URI="http://aboleo.net/software/portmon/downloads/${P}.tar.gz"
HOMEPAGE="http://aboleo.net/software/portmon/"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	econf --sysconfdir=/etc/portmon || die "Configure failed"
	emake || die "emake failed"
}

src_install() {
	into /usr
	dosbin src/portmon
	doman extras/portmon.8

	insinto /etc/portmon
	doins extras/portmon.hosts.sample
	dodoc AUTHORS BUGS README

	exeinto /etc/init.d
	newexe ${FILESDIR}/portmon.init portmon
}
