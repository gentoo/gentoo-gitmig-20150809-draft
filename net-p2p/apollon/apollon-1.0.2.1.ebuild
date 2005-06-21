# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/apollon/apollon-1.0.2.1.ebuild,v 1.2 2005/06/21 08:06:08 greg_g Exp $

inherit kde

#MY_P="${P}-1"
#S=${WORKDIR}/${MY_P}

DESCRIPTION="A KDE-based giFT GUI to search for and monitor downloads."
HOMEPAGE="http://apollon.sourceforge.net"
SRC_URI="mirror://sourceforge/apollon/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND=">=net-p2p/gift-0.11.4"
need-kde 3

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog HowToGetPlugins.README README TODO || die
}

