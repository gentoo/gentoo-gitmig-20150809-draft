# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/maradns/maradns-1.0.23.ebuild,v 1.5 2004/07/14 23:26:32 agriffis Exp $

inherit eutils

DESCRIPTION="Proxy DNS server with permanent caching"
HOMEPAGE="http://www.maradns.org"
SRC_URI="http://www.maradns.org/download/${P}.tar.bz2"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:PREFIX/man:PREFIX/share/man:" \
		-e "s:PREFIX/doc/maradns-\$VERSION:PREFIX/share/doc/${PF}:" \
		build/install.locations || die
}

src_compile() {
	econf || die
	emake FLAGS="${CFLAGS}" || die "compile problem"
}

src_install() {
	dodir /usr/{bin,sbin}
	dodir /usr/share/man/man{1,5,8}
	dodir /etc

	make \
		TOPLEVEL=${S} \
		BUILDDIR=${S}/build \
		RPM_BUILD_ROOT=${D} \
		PREFIX=${D}/usr \
		MAN1=${D}/usr/share/man/man1 \
		MAN5=${D}/usr/share/man/man5 \
		MAN8=${D}/usr/share/man/man8 \
		install || die

	exeinto /etc/init.d/; newexe ${FILESDIR}/maradns.rc6 maradns
}

pkg_postinst() {
	enewuser maradns 99 /bin/false /var/empty daemon
}
