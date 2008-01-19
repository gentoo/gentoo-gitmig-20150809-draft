# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpd/libmpd-0.15.0.ebuild,v 1.1 2008/01/19 14:07:12 angelos Exp $

DESCRIPTION="A library handling connection to a MPD server."
HOMEPAGE="http://sarine.nl/libmpd"
SRC_URI="http://download.sarine.nl/gmpc-0.15.5/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
