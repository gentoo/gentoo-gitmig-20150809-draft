# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/oidentd/oidentd-2.0.7-r1.ebuild,v 1.12 2005/06/07 04:22:45 redhatter Exp $

DESCRIPTION="Another (RFC1413 compliant) ident daemon"
HOMEPAGE="http://dev.ojnk.net/"
SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc alpha arm amd64 ia64 hppa ppc ~mips"
IUSE="ipv6"

DEPEND="virtual/libc"

src_compile() {
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		`use_enable ipv6` \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO NEWS \
		${FILESDIR}/oidentd_masq.conf ${FILESDIR}/oidentd.conf
	exeinto /etc/init.d ; newexe ${FILESDIR}/oidentd-${PV}-init oidentd
	insinto /etc/conf.d ; newins ${FILESDIR}/oidentd-${PV}-confd oidentd
}

pkg_postinst() {
	einfo Example configuration files are in /usr/share/doc/${PF}
}
