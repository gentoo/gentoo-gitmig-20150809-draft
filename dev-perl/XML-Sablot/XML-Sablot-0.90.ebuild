# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Sablot/XML-Sablot-0.90.ebuild,v 1.5 2002/07/25 04:56:39 seemant Exp $

inherit perl-module

MY_P=${PN}ron-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Perl Module for Sablotron"
SRC_URI="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${MY_P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${PN}.${PV}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86"

DEPEND="${DEPEND}
	>=app-text/sablotron-0.60"
