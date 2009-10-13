# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdissert/kdissert-1.0.7.ebuild,v 1.8 2009/10/13 22:35:17 ssuominen Exp $

inherit kde

DESCRIPTION="KDissert - a mindmapping-like tool"
HOMEPAGE="http://www.freehackers.org/~tnagy/kdissert/index.html"
SRC_URI="http://www.freehackers.org/~tnagy/kdissert/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="dev-lang/python"

need-kde 3.5

#LANGS="bg br cs da de el es fr ga gl it ka nl pl pt_BR pt ru sv tr"

src_unpack() {
	kde_src_unpack

	# Fixes bug 217553.
	epatch "${FILESDIR}/${P}-gcc43.patch"

	# Fix the desktop file.
	sed -i -e "s:\(MimeType=.*\):\1;:" "${S}"/src/appdata/kdissert.desktop
	sed -i -e "/Categories/s:QT:Qt:" "${S}"/src/appdata/kdissert.desktop
}

src_compile() {
	[[ -d ${QTDIR}/etc/settings ]] && addwrite "${QTDIR}/etc/settings"
	addpredict "${QTDIR}/etc/settings"

	local myconf="--kdeincludes=$(kde-config --prefix)/include --prefix=/usr "
	use amd64 && myconf="${myconf} --libsuffix=64"

	./waf configure ${myconf} || die "configure failed"
	./waf || die "waf failed"
}

src_install() {
	./waf --destdir="${D}" install
	dodoc AUTHORS README ROADMAP || die "dodoc failed"
	find "${D}"usr -name '*.la' -delete
}
