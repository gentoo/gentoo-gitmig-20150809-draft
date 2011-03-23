# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xvid4conf/xvid4conf-1.12.ebuild,v 1.18 2011/03/23 08:54:29 radhermit Exp $

EAPI=2

DESCRIPTION="GTK2-configuration dialog for xvid4"
HOMEPAGE="http://cvs.exit1.org/cgi-bin/viewcvs.cgi/xvid4conf/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.2.4:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	dodir /usr/{include,lib}
	einstall || die

	dodoc AUTHORS ChangeLog README
}
