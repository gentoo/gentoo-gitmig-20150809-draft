# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/flagedit/flagedit-0.0.5.ebuild,v 1.6 2010/08/25 17:27:32 idl0r Exp $

DESCRIPTION="CLI use flags and keyword editor, for system wide or /etc/portage files"
HOMEPAGE="http://damien.krotkine.com/the-player-of-games/flagedit.html"
SRC_URI="http://damien.krotkine.com/flagedit/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-lang/perl
>=dev-util/libconf-0.40.00"

src_install() {
	emake install PREFIX="${D}"/usr || die "make install failed"
}
