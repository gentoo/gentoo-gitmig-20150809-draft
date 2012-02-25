# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Abstract/Email-Abstract-3.3.0.ebuild,v 1.3 2012/02/25 17:50:38 klausman Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=3.003
inherit perl-module

DESCRIPTION="unified interface to mail representations"

SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/MRO-Compat
	>=dev-perl/Email-Simple-1.91
	>=virtual/perl-Module-Pluggable-1.5
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}"

SRC_TEST="do"
