# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/less/less-445-r1.ebuild,v 1.2 2011/11/17 16:24:26 ulm Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Excellent text file viewer"
HOMEPAGE="http://www.greenwoodsoftware.com/less/"
SRC_URI="http://www.greenwoodsoftware.com/less/${P}.tar.gz
	http://www-zeuthen.desy.de/~friebel/unix/less/code2color"

LICENSE="|| ( GPL-3 BSD-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="pcre unicode"

DEPEND=">=app-misc/editor-wrapper-3
	>=sys-libs/ncurses-5.2
	pcre? ( dev-libs/libpcre )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${P}.tar.gz
	cp "${DISTDIR}"/code2color "${S}"/
}

src_prepare() {
	epatch "${FILESDIR}"/code2color.patch
}

src_configure() {
	export ac_cv_lib_ncursesw_initscr=$(usex unicode)
	export ac_cv_lib_ncurses_initscr=$(usex !unicode)

	local regex="posix"
	use pcre && regex="pcre"

	econf \
		--with-regex=${regex} \
		--with-editor=/usr/libexec/editor
}

src_install() {
	emake install DESTDIR="${D}" || die

	dobin code2color || die "dobin"
	newbin "${FILESDIR}"/lesspipe.sh lesspipe || die "newbin"
	dosym lesspipe /usr/bin/lesspipe.sh
	newenvd "${FILESDIR}"/less.envd 70less

	dodoc NEWS README* "${FILESDIR}"/README.Gentoo
}

pkg_postinst() {
	einfo "lesspipe offers colorization options.  Run 'lesspipe -h' for info."
}
