# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/FileHandle-Unget/FileHandle-Unget-0.16.21.ebuild,v 1.1 2006/03/26 15:37:00 mcummings Exp $

inherit perl-module

MY_PV=${PV/16.21/1621}
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A FileHandle which supports ungetting of multiple bytes"
SRC_URI="mirror://cpan/authors/id/D/DC/DCOPPIT/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/DCOPPIT/${MY_P}.readme"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE=""

