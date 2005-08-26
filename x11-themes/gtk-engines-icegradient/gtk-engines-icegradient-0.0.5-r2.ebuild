# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-icegradient/gtk-engines-icegradient-0.0.5-r2.ebuild,v 1.2 2005/08/26 13:50:28 agriffis Exp $

DESCRIPTION="GTK+1 Ice Gradient Theme Engine (based on Thinice)"
SRC_URI="mirror://debian/pool/main/g/${PN}/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://themes.freshmeat.net/projects/icegradient/"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
SLOT="1"
IUSE="static"

DEPEND="=x11-libs/gtk+-1.2*"

S=${WORKDIR}/${P}.orig

src_compile() {
	local myconf="$(use_enable static)"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS CUSTOMIZATION ChangeLog NEWS README
}
