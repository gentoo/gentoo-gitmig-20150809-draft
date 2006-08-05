# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Locale-gettext/Locale-gettext-1.01-r1.ebuild,v 1.16 2006/08/05 13:33:32 mcummings Exp $

inherit perl-module

MY_P="gettext-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Perl module for accessing the GNU locale utilities"
HOMEPAGE="http://cpan.org/modules/by-module/Locale/${MY_P}.readme"
SRC_URI="http://cpan.org/modules/by-module/Locale/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="sys-devel/gettext
	dev-lang/perl"
RDEPEND="${DEPEND}"


