# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/pantomime/pantomime-1.2.0.20050606.ebuild,v 1.2 2005/08/25 19:03:49 swegener Exp $

inherit gnustep

S=${WORKDIR}/${P/p/P}

DESCRIPTION="A set of Objective-C classes that model a mail system."
HOMEPAGE="http://www.collaboration-world.com/pantomime/"
SRC_URI="mirror://gentoo/${P/p/P}.tar.bz2"

LICENSE="LGPL-2.1 Elm"
KEYWORDS="~x86 ~ppc"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}
	dev-libs/openssl"
RDEPEND="${GS_RDEPEND}
	dev-libs/openssl"

egnustep_install_domain "Local"
