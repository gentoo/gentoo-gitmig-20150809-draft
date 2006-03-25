# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/pantomime/pantomime-1.2.0.20060424.ebuild,v 1.1 2006/03/25 18:30:38 grobian Exp $

inherit gnustep

S=${WORKDIR}/${PN/p/P}

DESCRIPTION="A set of Objective-C classes that model a mail system."
HOMEPAGE="http://www.collaboration-world.com/pantomime/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="LGPL-2.1 Elm"
KEYWORDS="~x86 ~ppc"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}
	dev-libs/openssl"
RDEPEND="${GS_RDEPEND}
	dev-libs/openssl"

egnustep_install_domain "Local"
