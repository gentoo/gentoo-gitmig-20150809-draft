# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/varconf/varconf-0.6.7.ebuild,v 1.1 2012/01/28 21:09:02 tupone Exp $

DESCRIPTION="A configuration system designed for the STAGE server."
SRC_URI="mirror://sourceforge/worldforge/${P}.tar.bz2"
HOMEPAGE="http://www.worldforge.org/dev/eng/libraries/varconf"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-libs/libsigc++-2.0"
DEPEND="$RDEPEND
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO \
		|| die "Installing doc failed"
}
