# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/pantomime/pantomime-1.2.0_pre20040916.ebuild,v 1.1 2004/09/24 01:02:43 fafhrd Exp $

inherit gnustep

S=${WORKDIR}/${PN/p/P}

DESCRIPTION="A set of Objective-C classes that model a mail system."
HOMEPAGE="http://www.collaboration-world.com/pantomime/"
SRC_URI="http://dev.gentoo.org/~fafhrd/gnustep/src/libs/${P/p/P}.tar.gz"
LICENSE="LGPL-2.1 Elm"
KEYWORDS="~x86"
SLOT="0"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}
	dev-libs/openssl"
RDEPEND="${GS_RDEPEND}
	dev-libs/openssl"

