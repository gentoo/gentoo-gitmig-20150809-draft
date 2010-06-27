# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ImageSize/ImageSize-3.2.2.0.ebuild,v 1.4 2010/06/27 19:12:58 nixnut Exp $

EAPI=2

inherit versionator
MY_PN=Image-Size
MY_P=${MY_PN}-$(get_major_version).$(delete_all_version_separators $(get_after_major_version))
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=RJRAY
inherit perl-module

DESCRIPTION="The Perl Image-Size Module"

LICENSE="|| ( Artistic-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="
	virtual/perl-IO-Compress
	virtual/perl-File-Spec"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28"

SRC_TEST="do"
mydoc="ToDo"
