# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/oidentd/oidentd-2.0.8.ebuild,v 1.1 2006/08/27 03:21:54 avenj Exp $

DESCRIPTION="Another (RFC1413 compliant) ident daemon"
HOMEPAGE="http://dev.ojnk.net/"
SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~arm ~amd64 ~ia64 ~hppa ~ppc ~mips"
IUSE="ipv6"

DEPEND="virtual/libc"

src_compile() {
	econf $(use_enable ipv6) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "Install failed"

	dodoc AUTHORS ChangeLog README TODO NEWS \
		${FILESDIR}/oidentd_masq.conf ${FILESDIR}/oidentd.conf

	newinitd ${FILESDIR}/${PN}-2.0.7-init ${PN} || die "newinitd failed"
	newconfd ${FILESDIR}/${PN}-2.0.7-confd ${PN} || die "newconfd failed"

}

pkg_postinst() {
	einfo "Example configuration files are in /usr/share/doc/${PF}"
}
