# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/basket/basket-0.5.0.ebuild,v 1.8 2006/07/02 09:27:33 nelchael Exp $

inherit eutils kde autotools

DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
SRC_URI="http://basket.kde.org/downloads/index.php?file=${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="virtual/fam"

need-kde 3.3

src_unpack() {
	kde_src_unpack

	# patch from basket developer to solve compilation
	# problemes on systems without arts
	use arts || epatch ${FILESDIR}/${P}-noarts.patch
	use amd64 && epatch ${FILESDIR}/${P}-amd64-gcc4.1.patch

	einfo "Fixing Makefile.in to use FAM"
	sed -i -e "s/\(^basket_LDADD = .*$\)/\1 -lfam/" ${S}/src/Makefile.in
}
