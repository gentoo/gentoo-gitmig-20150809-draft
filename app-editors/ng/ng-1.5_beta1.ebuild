# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Id: ng-1.5_beta1.ebuild,v 1.1 2004/05/15 18:19:20 usata Exp $

IUSE="canna"

MY_P=${P/_beta/beta}

DESCRIPTION="Emacs like micro editor Ng -- based on mg2a"
SRC_URI="http://tt.sakura.ne.jp/~amura/archives/ng/${MY_P}.tar.gz"

HOMEPAGE="http://tt.sakura.ne.jp/~amura/ng/"

SLOT="0"
LICENSE="Emacs"
KEYWORDS="~x86"

PROVIDE="virtual/editor"
RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.0
	canna? ( app-i18n/canna )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}
	epatch "${FILESDIR}/${MY_P}-ncurses.patch"
}

src_compile() {

	local myconf

	myconf="`use_enable canna`"
	econf ${myconf} || die
	sed -i -e "s/^#undef NO_BACKUP/#define NO_BACKUP/" config.h \
		|| die "sed failed"

	emake || die
}

src_install() {

	dobin ng
	dodoc docs/* COPYING LICENSE MANIFEST dot.ng

	insinto /usr/share/ng
	doins bin/*

	insinto /etc/skel
	newins dot.ng .ng
}

pkg_postinst() {
	einfo
	einfo "If you want to use user Config"
	einfo "cp /etc/skel/.ng ~/.ng"
	einfo "and edit your .ng configuration file."
	einfo
}

