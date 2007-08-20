# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/trommler/trommler-3.7.ebuild,v 1.6 2007/08/20 23:35:32 jokey Exp $

inherit eutils toolchain-funcs

MY_PN=${PN/t/T}

DESCRIPTION="GTK+ based drum machine."
HOMEPAGE="http://muth.org/Robert/Trommler"
SRC_URI="http://muth.org/Robert/${MY_PN}/${P/-/.}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc -sparc x86"
IUSE="doc sox"

RDEPEND=">=x11-libs/gtk+-2
	sox? ( media-sound/sox )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}"/${MY_PN}

src_compile() {
	emake export.h || die "emake export.h failed."
	emake CFLAGS="${CFLAGS} $(pkg-config --cflags gtk+-2.0)" \
		CC="$(tc-getCC)" || die "emake failed."
}

src_install() {
	exeinto /usr/libexec
	doexe ${PN}
	newbin "${FILESDIR}"/${PN}.wrapper ${PN}
	dobin wav2smp playsample
	use sox && dobin smp2wav
	insinto /usr/share/${PN}/Drums
	doins Drums/*.smp
	insinto /usr/share/${PN}/Songs
	doins Songs/*.sng
	dodoc CHANGES README
	use doc && dohtml index.html style.css
	make_desktop_entry ${PN} Trommler
}
