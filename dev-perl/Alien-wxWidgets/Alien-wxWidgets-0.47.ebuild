# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Alien-wxWidgets/Alien-wxWidgets-0.47.ebuild,v 1.1 2009/12/06 16:10:14 tove Exp $

EAPI=2

WX_GTK_VER="2.8"
MODULE_AUTHOR=MBARBON
inherit perl-module wxwidgets

DESCRIPTION="Building, finding and using wxWidgets binaries"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="unicode"

SRC_TEST="do"

RDEPEND="x11-libs/wxGTK:2.8[X]
	>=virtual/perl-Module-Pluggable-3.1-r1"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-CBuilder-0.24
	virtual/perl-Module-Build"

perl-module_src_prep() {
	if use unicode; then
		need-wxwidgets unicode
	else
		need-wxwidgets gtk2
	fi

	echo no | perl Build.PL --installdirs=vendor \
		--destdir="${D}" \
		--libdoc= || die "perl Build.PL has failed!"
}
