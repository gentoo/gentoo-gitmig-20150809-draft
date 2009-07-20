# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/CPAN/CPAN-1.94.02.ebuild,v 1.1 2009/07/20 07:38:38 tove Exp $

EAPI=2

inherit versionator
MODULE_AUTHOR="ANDK"
MY_P=${PN}-$(delete_version_separator 2 )
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="query, download and build perl modules from CPAN sites"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

PATCHES=( "${FILESDIR}/1.94-Makefile.patch" )
