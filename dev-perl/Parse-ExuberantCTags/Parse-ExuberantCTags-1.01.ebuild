# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-ExuberantCTags/Parse-ExuberantCTags-1.01.ebuild,v 1.1 2010/02/15 13:26:18 tove Exp $

EAPI=2

MODULE_AUTHOR=SMUELLER
inherit perl-module

DESCRIPTION="Efficiently parse exuberant ctags files"

# contains readtags.c from ctags
LICENSE="${LICENSE} public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST=do
