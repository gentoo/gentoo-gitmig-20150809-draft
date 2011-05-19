# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Tags/Perl-Tags-0.280.0.ebuild,v 1.2 2011/05/19 19:20:44 grobian Exp $

EAPI=4

MODULE_AUTHOR=OSFAMERON
MODULE_VERSION=0.28
inherit perl-module

DESCRIPTION="Generate (possibly exuberant) Ctags style tags for Perl sourcecode"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="
	virtual/perl-File-Spec
	virtual/perl-File-Temp
	dev-perl/Module-Locate
	dev-perl/PPI
"
DEPEND="${RDEPEND}"

SRC_TEST="do"
