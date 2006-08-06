# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/text-autoformat/text-autoformat-1.12.ebuild,v 1.15 2006/08/06 03:11:26 mcummings Exp $

inherit perl-module

MY_P=Text-Autoformat-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Automatic text wrapping and reformatting"
SRC_URI="mirror://cpan/authors/id/D/DC/DCONWAY/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Text/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-perl/text-reform
	dev-lang/perl"
RDEPEND="${DEPEND}"

