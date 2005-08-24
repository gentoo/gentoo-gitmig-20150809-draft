# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/iso-codes/iso-codes-0.47.ebuild,v 1.3 2005/08/24 02:44:58 hparker Exp $

DESCRIPTION="Provides the list of country and language names"
HOMEPAGE="http://alioth.debian.org/projects/pkg-isocodes/"
SRC_URI="mirror://debian/pool/main/i/iso-codes/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/gettext
		>=dev-lang/python-2.3
		>=dev-python/pyxml-0.8.4
		>=sys-devel/automake-1.9"

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc ChangeLog README TODO
}
