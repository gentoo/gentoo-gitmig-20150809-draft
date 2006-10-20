# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Abstract/Email-Abstract-2.13.1.ebuild,v 1.5 2006/10/20 19:20:04 kloeri Exp $

inherit perl-module versionator

MY_PV="$(delete_version_separator 2)"
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="unified interface to mail representations"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rjbs/"

LICENSE="Artistic"
KEYWORDS="alpha amd64 ~ppc sparc ~x86"
IUSE=""

SRC_TEST="do"
SLOT="0"

DEPEND=">=dev-perl/Class-ISA-0.20
	>=dev-perl/Email-Simple-1.91
	>=dev-perl/Module-Pluggable-1.5
	dev-lang/perl"
