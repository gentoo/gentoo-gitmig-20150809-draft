# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/texinfo/texinfo-4.13.ebuild,v 1.6 2009/02/22 14:38:04 klausman Exp $

inherit flag-o-matic

DESCRIPTION="The GNU info program and utilities"
HOMEPAGE="http://www.gnu.org/software/texinfo/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.lzma"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="nls static"

RDEPEND="!=app-text/tetex-2*
	>=sys-libs/ncurses-5.2-r2
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	app-arch/lzma-utils
	nls? ( sys-devel/gettext )"

src_compile() {
	use static && append-ldflags -static
	econf $(use_enable nls) || die
	emake || die "emake"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS ChangeLog INTRODUCTION NEWS README TODO
	newdoc info/README README.info
	newdoc makeinfo/README README.makeinfo

	rm -f "${D}"/usr/lib/charset.alias #195148
}
