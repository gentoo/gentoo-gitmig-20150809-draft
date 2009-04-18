# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Archive-Tar/perl-Archive-Tar-1.38.ebuild,v 1.4 2009/04/18 16:11:37 tove Exp $

DESCRIPTION="A Perl module for creation and manipulation of tar files"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~mips"

IUSE=""
DEPEND=""

RDEPEND="|| ( ~dev-lang/perl-5.10.0 ~perl-core/Archive-Tar-${PV} )"
