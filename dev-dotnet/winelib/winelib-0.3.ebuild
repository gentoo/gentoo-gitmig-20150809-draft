# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/winelib/winelib-0.3.ebuild,v 1.9 2005/03/11 03:16:48 latexer Exp $

DESCRIPTION="Library for using Windows.Forms with Mono"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/beta2/${P}.tar.gz"
DEPEND=">=sys-apps/sed-4"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-0.95
	>=app-emulation/wine-20040121
	>=dev-dotnet/libgdiplus-0.9"

src_unpack() {
	unpack ${A}

	# Tries to make a bunch of nasty symlinks. We do it ourselves
	# in src_install
	cd ${S}
	sed -i "s:^\t(cd\(.*\):\t#(cd\1:" winelib/Makefile.in
}

src_compile() {
	econf --with-wine=${ROOT}/usr/lib/wine || die
	emake || die
}

src_install() {
	dodir /usr/lib
	einstall || die

	for lib in ${ROOT}/usr/lib/wine/lib/wine/*dll.so
	do
		dosym "${lib}" "/usr/lib/lib`basename ${lib}`"
	done

	dosym ${ROOT}/usr/lib/wine/lib/wine/user32.dll.so /usr/lib/user32.so
	dosym ${ROOT}/usr/lib/wine/lib/libwine.so.1 /usr/lib
	dosym ${ROOT}/usr/lib/wine/lib/libwine_unicode.so.1 /usr/lib

	dodoc ChangeLog
	docinto winelib/
	dodoc winelib/ChangeLog
}

pkg_postinst() {
	ewarn
	ewarn "Applications using winelib need ~/.wine to exist to function."
	ewarn "To get this created run 'wine' as the user in question."
	ewarn
}
