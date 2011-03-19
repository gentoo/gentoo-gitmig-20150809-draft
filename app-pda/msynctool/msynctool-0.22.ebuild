# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/msynctool/msynctool-0.22.ebuild,v 1.4 2011/03/19 05:46:23 dirtyepic Exp $

EAPI="3"

DESCRIPTION="OpenSync msync tool"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/downloads/releases/${PV}/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="~app-pda/libopensync-${PV}
	dev-libs/glib:2
	dev-libs/libxml2
	!app-pda/osynctool"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

src_prepare() {
	sed -i -e 's: -Werror::g' \
		-e 's: -R $(libdir)::g' \
		tools/Makefile.in
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README
}
