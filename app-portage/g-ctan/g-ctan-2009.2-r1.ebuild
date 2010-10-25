# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/g-ctan/g-ctan-2009.2-r1.ebuild,v 1.1 2010/10/25 14:44:12 fauli Exp $

EAPI=2

DESCRIPTION="Generate and install ebuilds from the TeXLive package manager"
HOMEPAGE="http://launchpad.net/g-ctan"
SRC_URI="http://launchpad.net/g-ctan/2009/${PV}/+download/${P}.tar.bz2"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
DEPEND=""
RDEPEND="~app-text/texlive-2009
	app-arch/xz-utils
	>=dev-libs/libpcre-0.7.6"

src_prepare() {
	sed -e "s;^CTANURL=.*;CTANURL=ftp://tug.org/historic/systems/texlive/2009/tlnet/;" -i "${S}"/modules/common || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}

pkg_postinst() {
	ewarn "The default storage directory has changed to /var/lib/g-ctan."
	ewarn "Please adjust your configuration."
}
