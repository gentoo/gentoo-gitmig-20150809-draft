# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-cleanice/gtk-engines-cleanice-0.8.5.ebuild,v 1.7 2005/08/24 00:40:51 leonardop Exp $

MY_PN="gtk-cleanice-theme"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Cleanice theme engine for GTK+ 1"
HOMEPAGE="http://themes.freshmeat.net/"
SRC_PATH="${PN:0:1}/${PN}/${PN}_${PV}.orig.tar.gz"
SRC_URI="mirror://debian/pool/main/${SRC_PATH}"

KEYWORDS="x86 ppc alpha sparc hppa amd64"
LICENSE="GPL-2"
SLOT="1"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"

S=${WORKDIR}/${MY_P}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog README
}
