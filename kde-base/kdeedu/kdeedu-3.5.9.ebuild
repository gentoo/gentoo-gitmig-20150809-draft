# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.5.9.ebuild,v 1.6 2008/05/12 16:07:27 ranger Exp $

EAPI="1"
inherit kde-dist eutils

DESCRIPTION="KDE educational apps"

KEYWORDS="alpha ~amd64 ~hppa ia64 ~mips ppc ppc64 sparc ~x86"
IUSE="kig-scripting solver"

DEPEND="kig-scripting? ( >=dev-libs/boost-1.32 )
		solver? ( >=dev-ml/facile-1.1 )"

pkg_setup() {
	if use solver && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build the solver for ${PN}, you first need"
		eerror "to have dev-lang/ocaml built with the ocamlopt useflag"
		eerror "in order to get a native code ocaml compiler"
		die "Please install dev-lang/ocaml with ocamlopt support"
	fi
	if use solver && ! built_with_use --missing true dev-ml/facile ocamlopt; then
		eerror "In order to build the solver for ${PN}, you first need"
		eerror "to have dev-ml/facile built with the ocamlopt useflag"
		eerror "in order to get the native code library"
		die "Please install dev-ml/facile with ocamlopt support"
	fi
	kde_pkg_setup
}

src_unpack() {
	kde_src_unpack

	# Fix ktouch's desktop file
	sed -i -e "s:\(Categories=.*\)Miscellaneous;:\1:" "${S}/ktouch/ktouch.desktop"
}

src_compile() {
	local myconf="$(use_enable kig-scripting kig-python-scripting)
				$(use_enable solver ocamlsolver)"

	kde_src_compile
}
