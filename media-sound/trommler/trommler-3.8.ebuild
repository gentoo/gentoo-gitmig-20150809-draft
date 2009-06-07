# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/trommler/trommler-3.8.ebuild,v 1.4 2009/06/07 16:34:49 nixnut Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="GTK+ based drum machine."
HOMEPAGE="http://muth.org/Robert/Trommler"
SRC_URI="http://muth.org/Robert/${PN/t/T}/${P/-/.}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ~sparc ~x86"
IUSE="+sox"

RDEPEND="x11-libs/gtk+:2
	sox? ( media-sound/sox )"
DEPEND="${RDEPEND}
	x11-misc/makedepend
	dev-util/pkgconfig"

S=${WORKDIR}/${PN/t/T}

src_compile() {
	emake export.h || die "emake export.h failed"
	emake CFLAGS="${CFLAGS} $(pkg-config --cflags gtk+-2.0)" \
		CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	exeinto /usr/libexec
	doexe ${PN} || die "doexe failed"
	newbin "${FILESDIR}"/${PN}.wrapper ${PN} || die "newbin failed"
	dobin wav2smp playsample || die "dobin failed"
	if use sox; then
		dobin smp2wav || die "dobin failed"
	fi
	insinto /usr/share/${PN}/Drums
	doins Drums/*.smp || die "doins failed"
	insinto /usr/share/${PN}/Songs
	doins Songs/*.sng || die "doins failed"
	dodoc CHANGES README
	dohtml index.html style.css
	make_desktop_entry ${PN} Trommler
}
