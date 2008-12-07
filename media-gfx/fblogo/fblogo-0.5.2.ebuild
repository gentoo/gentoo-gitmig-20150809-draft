# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fblogo/fblogo-0.5.2.ebuild,v 1.9 2008/12/07 12:12:13 vapier Exp $

inherit eutils toolchain-funcs

IUSE=""

DESCRIPTION="Creates images to substitute Linux boot logo"
#HOMEPAGE="http://freakzone.net/gordon/#fblogo"
HOMEPAGE="http://www.gentoo.org/"
#SRC_URI="http://freakzone.net/gordon/src/${P}.tar.gz"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="arm ~ppc ~sparc x86"

RDEPEND="media-libs/libpng
	sys-libs/zlib"

DEPEND=">=sys-apps/sed-4
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/fblogo-0.5.2-cross.patch

	sed -i -e '/-o fblogo/d' \
		-e 's:LIBS:LDLIBS:' \
		Makefile || die "Makefile fix failed"
}

src_compile() {
	tc-export CC
	emake CC="${CC}" || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README CHANGES
}
