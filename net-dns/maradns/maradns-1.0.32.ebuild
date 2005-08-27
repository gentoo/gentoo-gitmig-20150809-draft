# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/maradns/maradns-1.0.32.ebuild,v 1.1 2005/08/27 01:10:56 matsuu Exp $

inherit eutils

DESCRIPTION="Proxy DNS server with permanent caching"
HOMEPAGE="http://www.maradns.org/"
SRC_URI="http://www.maradns.org/download/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:PREFIX/man:PREFIX/share/man:" \
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

	newinitd ${FILESDIR}/maradns.rc6 maradns
}

pkg_postinst() {
	enewuser maradns 99 -1 /var/empty daemon
}
