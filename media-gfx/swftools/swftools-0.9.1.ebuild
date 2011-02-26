# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/swftools/swftools-0.9.1.ebuild,v 1.2 2011/02/26 18:27:35 signals Exp $

EAPI=2
inherit eutils

DESCRIPTION="SWF Tools is a collection of SWF manipulation and generation utilities"
HOMEPAGE="http://www.swftools.org/"
SRC_URI="http://www.swftools.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/t1lib-1.3.1
	media-libs/freetype
	virtual/jpeg"
DEPEND="${RDEPEND}
	!<media-libs/ming-0.4.0_rc2"

src_configure() {
	econf
	# disable the python interface; there's no configure switch; bug 118242
	echo "all install uninstall clean:" > lib/python/Makefile
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog
}
