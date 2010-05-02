# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateManip/DateManip-6.11.ebuild,v 1.1 2010/05/02 21:58:06 robbat2 Exp $

EAPI=2

MY_PN=Date-Manip
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=SBECK
inherit perl-module

DESCRIPTION="Perl date manipulation routines"

SLOT="0"
# Temporarily dropped pending bug #318219
KEYWORDS="~amd64 ~x86" #~ppc-aix ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x86-solaris"
IUSE="test"

# WARNING, the 6.x tarballs DO also include the 5.x version, and the build
# system actually installs the 5.x version if you have perl 5.8!
RDEPEND=">=dev-lang/perl-5.10
	dev-perl/YAML-Syck
	virtual/perl-Storable"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	dev-perl/Test-Inter
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"

mydoc="HISTORY TODO README.first"
