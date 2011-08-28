# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-AutoWriter/XML-AutoWriter-0.400.0.ebuild,v 1.1 2011/08/28 07:03:21 tove Exp $

EAPI=4

MODULE_AUTHOR=PERIGRIN
MODULE_VERSION=0.4
inherit perl-module

DESCRIPTION="DOCTYPE based XML output"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/XML-Parser"
DEPEND="${RDEPEND}"

SRC_TEST="do"
