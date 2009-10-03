# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/fmio/fmio-2.0.8.ebuild,v 1.3 2009/10/03 16:58:47 maekke Exp $

inherit toolchain-funcs

DESCRIPTION="fm radio card manipulation utilities"
HOMEPAGE="http://jumbo.narod.ru/fmio.html"
SRC_URI="http://jumbo.narod.ru/src/fmio/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="X linguas_ru"

DEPEND="X? ( x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXext )"

src_compile() {
	tc-export CC
	cd "${S}"/src
	emake lib fmio || die "src/emake failed."

	cd "${S}"/utils
	emake bktrctl fmrinit || die "utils/emake failed."

	if use X; then
		cd "${S}"/xsrc
		emake wmfmio || die "xsrc/emake failed."
	fi
}

src_install() {
	dobin src/fmio utils/{bktrctl,fmrinit} || die "dobin failed."
	doman src/fmio.1
	#dolib.a src/libradio.a (only for experimental convinience.)

	if use X; then
		dobin xsrc/wmfmio || die "xsrc/dobin failed."
		doman xsrc/wmfmio.1
		insinto /etc
		newins xsrc/sample.wmfmiorc wmfmiorc || die "doins failed."
	fi

	use linguas_ru && dodoc doc/FAQ.ru
	dodoc Changelog README doc/FAQ
}
