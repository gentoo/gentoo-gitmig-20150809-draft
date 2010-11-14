# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gerbv/gerbv-1.0.1-r1.ebuild,v 1.12 2010/11/14 17:26:48 armin76 Exp $

inherit eutils

DESCRIPTION="gerbv - The gEDA Gerber Viewer"
SRC_URI="http://www.geda.seul.org/dist/${P}.tar.gz"
HOMEPAGE="http://www.geda.seul.org"

IUSE="doc png xinerama"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

RDEPEND="=x11-libs/gtk+-2*
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

src_compile() {
	local confOptions

	confOptions='--enable-gtk2'
	use xinerama && epatch "${FILESDIR}/${PN}-1.0.0-Xinerama.patch"
	use png || confOptions="$confOptions --disable-exportpng"
	epatch "${FILESDIR}/${PN}-1.0.0-gcc-4.10.patch"

	econf $confOptions || die
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	if use doc; then
		cd doc
		dodoc sources.txt
		use png && dodoc PNG-print/PNGPrintMiniHowto.txt
		docinto eagle
		dodoc eagle/eagle2exc*
	fi
}
