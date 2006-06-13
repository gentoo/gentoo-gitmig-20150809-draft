# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/nis-utils/nis-utils-1.4.1-r1.ebuild,v 1.6 2006/06/13 18:23:51 gustavoz Exp $

inherit eutils

DESCRIPTION="NIS+ utilities"
HOMEPAGE="http://www.linux-nis.org/"
SRC_URI="mirror://kernel/linux/utils/net/NIS+/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc x86"
IUSE="nls"

DEPEND="dev-libs/gmp"

RESTRICT="test"

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
