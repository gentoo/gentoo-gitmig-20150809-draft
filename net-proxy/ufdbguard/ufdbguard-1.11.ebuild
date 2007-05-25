# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/ufdbguard/ufdbguard-1.11.ebuild,v 1.2 2007/05/25 11:28:19 bass Exp $

inherit eutils
DESCRIPTION="ufdbGuard is a redirector for the Squid internet proxy."
HOMEPAGE="http://ufdbguard.sf.net"
SRC_URI="mirror://sourceforge/ufdbguard/ufdbGuard-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-libs/openssl
		app-arch/bzip2
		dev-util/yacc
		sys-devel/flex"
RDEPEND="${DEPEND}
		net-misc/wget
		net-proxy/squid"

S="${WORKDIR}/ufdbGuard-${PV}"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--with-ufdb-config=/etc/ufdbguard \
		--with-ufdb-logdir=/var/log/ufdbguard \
		--with-ufdb-dbhome=/etc/ufdbguard/blacklists \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	dodoc CHANGELOG INSTALL README README.multithreaded TODO
	dodoc doc/*.txt src/UFDB
	dohtml doc/*.html

	dobin src/ufdbGenTable src/ufdbGuard src/mtserver/ufdbgclient src/mtserver/ufdbguardd src/ufdbGrab

	dodir /etc/ufdbguard/blacklists
	insinto /etc/ufdbguard
	doins src/ufdbGuard.conf

	newconfd ${FILESDIR}/ufdbguard.confd ufdbguard
	newinitd ${FILESDIR}/ufdbguard.initd ufdbguard
}

pkg_postinst() {
	einfo "Add ufdbguard port to services:"
	einfo 'echo "ufdbguardd      3977/tcp" >> /etc/services '
}
