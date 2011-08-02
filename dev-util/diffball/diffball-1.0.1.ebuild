# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/diffball/diffball-1.0.1.ebuild,v 1.1 2011/08/02 05:31:16 ferringb Exp $

DESCRIPTION="Delta compression suite for using/generating binary patches"
HOMEPAGE="http://diffball.googlecode.com/"
SRC_URI="http://diffball.googlecode.com/files/${PN}-${PV}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="debug"

DEPEND=">=sys-libs/zlib-1.1.4
	>=app-arch/bzip2-1.0.2
	app-arch/xz-utils"
RDEPEND="${DEPEND}"

# Invalid RESTRICT for source package. Investigate.
RESTRICT="strip"

src_compile() {
	econf $(use_enable debug asserts)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
