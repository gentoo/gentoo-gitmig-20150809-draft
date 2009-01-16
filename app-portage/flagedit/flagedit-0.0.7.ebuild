# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/flagedit/flagedit-0.0.7.ebuild,v 1.8 2009/01/16 21:59:58 dams Exp $

IUSE=""

DESCRIPTION="CLI use flags and keyword editor, for system wide or /etc/portage files"
HOMEPAGE="http://damien.krotkine.com/flagedit/"
SRC_URI="http://damien.krotkine.com/flagedit/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~ppc64 x86 ~x86-fbsd"

RDEPEND="dev-lang/perl
>=dev-util/libconf-0.40.00"

src_install() {
	make install PREFIX="${D}"/usr || die "make install failed"
}
