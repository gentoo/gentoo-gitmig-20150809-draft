# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/quilt/quilt-0.32.ebuild,v 1.2 2004/07/21 18:30:36 dholm Exp $

inherit eutils

DESCRIPTION="quilt patch manager"
HOMEPAGE="http://savannah.nongnu.org/projects/quilt"

SRC_URI="http://savannah.nongnu.org/download/quilt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"

DEPEND="sys-devel/patch
	>=sys-apps/sed-4
	app-arch/bzip2
	app-arch/gzip
	dev-util/diffstat
	sys-apps/gawk
	sys-apps/sed
	dev-lang/perl"

src_compile() {
	econf || die "failed to configure ${P}"
	emake || die "emake failed"
}

src_install() {
	make BUILD_ROOT=${D} install || die
}
