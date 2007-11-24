# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ptabtools/ptabtools-0.4.3.ebuild,v 1.3 2007/11/24 14:09:38 cla Exp $

inherit multilib

DESCRIPTION="Utilities for PowerTab Guitar files (.ptb)"
HOMEPAGE="http://jelmer.vernstok.nl/oss/ptabtools"
SRC_URI="http://jelmer.vernstok.nl/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="dev-libs/popt
	dev-libs/libxml2
	dev-libs/libxslt"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" libdir="/usr/$(get_libdir)" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README ROADMAP TODO
}
