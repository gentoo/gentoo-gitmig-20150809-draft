# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/bidiv/bidiv-1.5-r1.ebuild,v 1.3 2012/05/18 08:07:04 ago Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A BiDirectional Text Viewer"
HOMEPAGE="http://www.ivrix.org.il"
SRC_URI="http://ftp.ivrix.org.il/pub/ivrix/src/cmdline/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-libs/fribidi"
DEPEND="${DEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-fribidi.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" CC_OPT_FLAGS="${CFLAGS}" || die "emake failed."
}

src_install() {
	dobin bidiv
	dodoc README WHATSNEW
	doman bidiv.1
}
