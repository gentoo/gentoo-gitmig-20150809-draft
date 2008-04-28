# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/wxperl/wxperl-0.82.ebuild,v 1.1 2008/04/28 23:23:46 yuval Exp $

inherit perl-module

MY_P="Wx-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for wxGTK"
HOMEPAGE="http://wxperl.sourceforge.net/"
SRC_URI="mirror://cpan/authors/id/M/MB/MBARBON/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

DEPEND="=x11-libs/wxGTK-2.6*
	>=dev-perl/Alien-wxWidgets-0.25
	>=dev-lang/perl-5.8.4
	virtual/perl-Test-Harness
	>=virtual/perl-File-Spec-0.82"
