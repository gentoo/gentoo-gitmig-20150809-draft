# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/YAML-Parser-Syck/YAML-Parser-Syck-0.01.ebuild,v 1.9 2010/01/29 12:41:04 tove Exp $

EAPI=2

MODULE_AUTHOR=INGY
inherit perl-module

DESCRIPTION="Perl Wrapper for the YAML Parser Extension: libsyck"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-libs/syck"
DEPEND="${RDEPEND}"

SRC_TEST="do"
