# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MRO-Compat/MRO-Compat-0.110.0.ebuild,v 1.4 2012/02/25 17:51:00 klausman Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="Lets you build groups of accessors"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86 ~ppc-macos ~x64-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	>=dev-perl/Class-C3-0.20"
#	>=dev-perl/Class-C3-XS-0.08"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do
