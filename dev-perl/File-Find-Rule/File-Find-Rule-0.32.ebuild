# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Find-Rule/File-Find-Rule-0.32.ebuild,v 1.1 2009/11/28 11:50:04 tove Exp $

EAPI=2

MODULE_AUTHOR=RCLAMP
inherit perl-module

DESCRIPTION="Alternative interface to File::Find"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND="virtual/perl-File-Spec
	dev-perl/Number-Compare
	dev-perl/Text-Glob"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
