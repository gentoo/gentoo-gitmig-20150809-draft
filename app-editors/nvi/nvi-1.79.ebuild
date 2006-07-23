# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nvi/nvi-1.79.ebuild,v 1.1 2006/07/23 10:50:14 truedfx Exp $

inherit eutils

DESCRIPTION="Vi clone"
HOMEPAGE="http://www.bostic.com/vi/"
SRC_URI="ftp://ftp.sleepycat.com/pub/${P}.tar.gz"

LICENSE="Sleepycat"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64 ~ppc64"
IUSE=""

DEPEND=""
RDEPEND="!app-editors/vim
	!app-editors/gvim"
PROVIDE="virtual/editor"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	# Fix bug 23888
	epatch "${FILESDIR}"/${PN}-1.81.5-tcsetattr.patch
}

src_compile() {
	cd build
	econf --program-prefix=n \
		--disable-curses \
		--disable-re \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	cd build
	einstall || die "install failed"
}

pkg_postinst() {
	[[ ! -e "${ROOT}"/usr/bin/vi ]] &&
		ln -sf nvi "${ROOT}"/usr/bin/vi
	[[ ! -e "${ROOT}"/usr/bin/ex ]] &&
		ln -sf nvi "${ROOT}"/usr/bin/ex
	[[ ! -e "${ROOT}"/usr/bin/view ]] &&
		ln -sf nvi "${ROOT}"/usr/bin/view
}

pkg_postrm() {
	[[ -L "${ROOT}"/usr/bin/vi && ! -f "${ROOT}"/usr/bin/vi ]] &&
		rm -f "${ROOT}"/usr/bin/vi
	[[ -L "${ROOT}"/usr/bin/ex && ! -f "${ROOT}"/usr/bin/ex ]] &&
		rm -f "${ROOT}"/usr/bin/ex
	[[ -L "${ROOT}"/usr/bin/view && ! -f "${ROOT}"/usr/bin/view ]] &&
		rm -f "${ROOT}"/usr/bin/view
}
