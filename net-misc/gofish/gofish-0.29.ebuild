# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gofish/gofish-0.29.ebuild,v 1.3 2004/04/27 21:37:23 agriffis Exp $

inherit eutils

IUSE=""

S="${WORKDIR}/gofish-${PV}"
HOMEPAGE="http://gofish.sourceforge.net"
DESCRIPTION="Gofish gopher server"
SRC_URI="mirror://sourceforge/gofish/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc
		>=sys-apps/sed-4"
RDEPEND=""


src_compile() {
	econf --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
		--disable-http || die "econf failed"
	emake || die
}

src_install () {
	sed -i s/';uid = -1'/'uid = 30'/ ${S}/gofish.conf
	sed -i s/';gid = -1'/'uid = 30'/ ${S}/gofish.conf
	make DESTDIR=${D} install  || die
	exeinto /etc/init.d ; newexe ${FILESDIR}/gofish.rc gofish
	insinto /etc/conf.d ; newins ${FILESDIR}/gofish.confd gofish
}


pkg_postinst() {
	enewgroup "gopher"  30
	enewuser  "gopher"  30  "/bin/false" "/dev/null"  "gopher"

	einfo
	einfo "You have to edit the configuration file"
	einfo "/etc/gofish.conf if this is a new install"
	einfo
}
