# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/einit-modules-scheme/einit-modules-scheme-1.0.0.2.ebuild,v 1.2 2008/04/24 11:49:49 opfer Exp $

inherit eutils python

DESCRIPTION="Scheme modules for eINIT"
SRC_URI="http://einit.jyujin.de/files/${P}.tar.bz2"
HOMEPAGE="http://einit.jyujin.de/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=sys-apps/einit-0.40.0
		 >=dev-scheme/guile-1.8"
DEPEND="${RDEPEND}
		dev-util/scons"

pkg_setup() {
	if ! built_with_use "dev-scheme/guile" 'threads' ; then
		die "you need to build guile with USE='threads'"
	fi
}

src_unpack() {
	unpack ${A} || die
	python_version || die
}

src_compile() {
	scons libdir="$(get_libdir)" destdir="${D}/${ROOT}/" prefix="${ROOT}" || die
}

src_install() {
	scons libdir="$(get_libdir)" destdir="${D}/${ROOT}/" prefix="${ROOT}" install || die
	dodoc README || die
}
