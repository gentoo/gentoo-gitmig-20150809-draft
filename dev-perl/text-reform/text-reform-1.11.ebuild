# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/text-reform/text-reform-1.11.ebuild,v 1.2 2004/04/15 18:15:44 randy Exp $

inherit perl-module

MY_P=Text-Reform-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Manual text wrapping and reformatting"
SRC_URI="http://www.cpan.org/modules/by-module/Text/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Text/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~amd64 ~ppc ~sparc ~alpha ~hppa s390"

DEPEND="${DEPEND}"
