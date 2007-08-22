# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/pantomime/pantomime-1.2.0.20060925.ebuild,v 1.3 2007/08/22 16:26:57 uberlord Exp $

inherit gnustep

MY_PN=${PN/p/P}
MY_PV=${PV%.*}

S=${WORKDIR}/${MY_PN}

DESCRIPTION="A set of Objective-C classes that model a mail system."
HOMEPAGE="http://www.collaboration-world.com/pantomime/"
SRC_URI="http://www.collaboration-world.com/pantomime.data/releases/Stable/${MY_PN}-${MY_PV}pre2.tar.gz"

LICENSE="LGPL-2.1 Elm"
KEYWORDS="~ppc ~x86 ~x86-fbsd"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}
	dev-libs/openssl"
RDEPEND="${GS_RDEPEND}
	dev-libs/openssl"

egnustep_install_domain "System"

src_install() {
	egnustep_env
	egnustep_install

	dodoc ${S}/Documentation/*
	docinto rfc
	dodoc ${S}/Documentation/RFC/*
}
