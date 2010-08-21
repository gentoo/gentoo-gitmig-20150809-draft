# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aylet/aylet-0.5.ebuild,v 1.7 2010/08/21 02:19:36 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Aylet plays music files in the .ay format."
HOMEPAGE="http://rus.members.beeb.net/aylet.html"
SRC_URI="http://ftp.ibiblio.org/pub/Linux/apps/sound/players/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE="gtk"

RDEPEND="sys-libs/ncurses
	gtk? ( x11-libs/gtk+:2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gtk.patch
}

src_compile() {
	tc-export CC

	emake ${PN} || die
	use gtk && { emake gtk2 || die; }
}

src_install() {
	dobin ${PN} || die
	use gtk && { dobin x${PN} || die; }

	local mansuffix=$(ecompress --suffix)
	doman ${PN}.1
	use gtk && dosym aylet.1${mansuffix} /usr/share/man/man1/xaylet.1${mansuffix}

	dodoc ChangeLog NEWS README TODO
}
