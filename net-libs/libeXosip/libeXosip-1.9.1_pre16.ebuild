# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libeXosip/libeXosip-1.9.1_pre16.ebuild,v 1.1 2005/08/21 04:32:53 dragonheart Exp $

MY_P=${PN}2-${PV/_/-}
DESCRIPTION="eXosip is a library that hides the complexity of using the SIP protocol for mutlimedia session establishement."
HOMEPAGE="http://savannah.nongnu.org/projects/exosip/"
SRC_URI="http://www.antisip.com/download/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"

DEPEND=">=net-libs/libosip-2.2.0"
S=${WORKDIR}/${MY_P}

src_compile() {
	econf --disable-josua || die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc README ChangeLog INSTALL AUTHORS COPYING NEWS
}
