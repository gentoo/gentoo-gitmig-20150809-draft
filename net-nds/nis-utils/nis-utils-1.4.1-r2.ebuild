# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/nis-utils/nis-utils-1.4.1-r2.ebuild,v 1.4 2008/07/27 20:34:00 antarus Exp $

inherit eutils

DESCRIPTION="NIS+ utilities"
HOMEPAGE="http://www.linux-nis.org/"
SRC_URI="mirror://kernel/linux/utils/net/NIS+/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE="nls"

DEPEND="dev-libs/gmp
		!>sys-libs/glibc-2.5"

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-gmp-fixes.patch"
}

src_compile() {
	econf $(use_enable nls) || die "Configure failed"
	emake || die "Make Failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install Failed"
	mv "${D}"/usr/etc "${D}"/
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO
	newinitd "${FILESDIR}"/keyserv.rc keyserv
}
