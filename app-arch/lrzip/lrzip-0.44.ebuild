# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lrzip/lrzip-0.44.ebuild,v 1.2 2010/04/13 19:19:52 hwoarang Exp $

DESCRIPTION="Long Range ZIP or Lzma RZIP"
HOMEPAGE="http://ck.kolivas.org/apps/lrzip/README"
SRC_URI="http://ck.kolivas.org/apps/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-libs/lzo
		app-arch/bzip2
		sys-libs/zlib"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
