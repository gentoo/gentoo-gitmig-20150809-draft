# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/read-edid/read-edid-1.4.1-r1.ebuild,v 1.4 2007/09/28 07:21:39 mr_bones_ Exp $

inherit autotools eutils

DESCRIPTION="program that can get information from a pnp monitor."
HOMEPAGE="http://john.fremlin.de/programs/linux/read-edid/index.html"
SRC_URI="http://john.fremlin.de/programs/linux/read-edid/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc x86"
IUSE=""

# Temporary solution for bug 187535 as upstream changed tarball without
# raising version number. Can be removed when our mirrors don't include
# outdated tarball anymore.
RESTRICT="mirror"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-arch.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog LRMI NEWS README
}
