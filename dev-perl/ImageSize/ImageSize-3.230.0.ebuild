# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ImageSize/ImageSize-3.230.0.ebuild,v 1.7 2012/03/25 16:20:21 armin76 Exp $

EAPI=4

MY_PN=Image-Size
MODULE_AUTHOR=RJRAY
MODULE_VERSION=3.230
inherit perl-module

DESCRIPTION="The Perl Image-Size Module"

LICENSE="|| ( Artistic-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="
	virtual/perl-IO-Compress
	virtual/perl-File-Spec"
DEPEND="${RDEPEND}"

SRC_TEST="do"
mydoc="ToDo"
