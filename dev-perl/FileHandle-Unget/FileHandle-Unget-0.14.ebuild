# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/FileHandle-Unget/FileHandle-Unget-0.14.ebuild,v 1.2 2004/06/08 12:25:44 dholm Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A FileHandle which supports ungetting of multiple bytes"
SRC_URI="http://www.cpan.org/modules/by-module/Mail/DCOPPIT/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/DCOPPIT/${P}.readme"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

DEPEND="dev-perl/WeakRef"
