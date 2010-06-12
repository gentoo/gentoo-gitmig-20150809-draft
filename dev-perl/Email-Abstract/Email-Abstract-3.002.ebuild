# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Abstract/Email-Abstract-3.002.ebuild,v 1.1 2010/06/12 12:43:49 tove Exp $

EAPI=3

#inherit versionator
#MY_P="${PN}-$(delete_version_separator 2)"
#S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="unified interface to mail representations"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=virtual/perl-Class-ISA-0.20
	>=dev-perl/Email-Simple-1.91
	>=virtual/perl-Module-Pluggable-1.5
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}"

SRC_TEST="do"
