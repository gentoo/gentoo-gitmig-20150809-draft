# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/herdstat/herdstat-0.1.ebuild,v 1.1 2005/03/04 17:35:40 ka0ttic Exp $

DESCRIPTION="Utility that parses Gentoo's herds.xml and displays statistics"
HOMEPAGE="http://butsugenjitemple.org/~ka0ttic/"
SRC_URI="http://butsugenjitemple.org/gentoo/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"

RDEPEND="dev-libs/xmlwrapp
	net-misc/wget"
DEPEND="dev-libs/xmlwrapp
	>=sys-apps/sed-4"

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	keepdir /var/lib/herdstat
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
}

pkg_postinst() {
	chown root:portage /var/lib/herdstat
	chmod 0775 /var/lib/herdstat
}
