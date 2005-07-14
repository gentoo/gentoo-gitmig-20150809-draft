# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/wxperl/wxperl-0.22.ebuild,v 1.5 2005/07/14 23:28:00 agriffis Exp $

inherit perl-module eutils wxwidgets

MY_P="Wx-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for wxGTK"
HOMEPAGE="http://wxperl.sourceforge.net/"
SRC_URI="mirror://cpan/authors/id/M/MB/MBARBON/${MY_P}.tar.gz"

LICENSE="|| (Artistic GPL-2)"
SLOT="0"
KEYWORDS="~x86"
IUSE="unicode"

DEPEND="x11-libs/wxGTK
		>=dev-lang/perl-5.8.4
		>=perl-core/File-Spec-0.82
		!=perl-core/ExtUtils-MakeMaker-6.21"

src_compile() {
	WX_GTK_VER="2.6"
	if use unicode; then
		need-wxwidgets unicode
	else
		need-wxwidgets gtk2
	fi
	perl-module_src_compile
}
