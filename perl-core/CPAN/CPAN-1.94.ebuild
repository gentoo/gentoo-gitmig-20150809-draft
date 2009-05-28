# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/CPAN/CPAN-1.94.ebuild,v 1.1 2009/05/28 11:10:43 tove Exp $

EAPI=2

#inherit versionator
MODULE_AUTHOR="ANDK"
#MY_P=${PN}-$(delete_version_separator 2 )
#S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="query, download and build perl modules from CPAN sites"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!!<dev-lang/perl-5.8.8-r7"

PATCHES=( "${FILESDIR}/${PV}-Makefile.patch" )
