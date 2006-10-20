# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/wxperl/wxperl-0.57.ebuild,v 1.2 2006/10/20 18:06:11 mcummings Exp $

inherit perl-module eutils wxwidgets

MY_P="Wx-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for wxGTK"
HOMEPAGE="http://wxperl.sourceforge.net/"
SRC_URI="mirror://cpan/authors/id/M/MB/MBARBON/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="unicode"

DEPEND=">=x11-libs/wxGTK-2.6.2-r1
	dev-perl/Alien-wxWidgets
	>=dev-lang/perl-5.8.4
	>=virtual/perl-File-Spec-0.82"

src_compile() {
	WX_GTK_VER="2.6"
	if use unicode; then
		need-wxwidgets unicode
	else
		need-wxwidgets gtk2
	fi
	perl-module_src_compile
}
