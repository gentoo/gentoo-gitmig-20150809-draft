# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/universalkopete/universalkopete-0.1.ebuild,v 1.4 2005/01/17 08:49:53 danarmak Exp $

inherit kde

S=${WORKDIR}/universalkopete

DESCRIPTION="Allows Kopete to embed into the Universal Sidebar and become part\
			of your KDE desktop as opposed to a floating window."
SRC_URI="http://www.nemohackers.org/software/universalkopete/${P}.tar.bz2
		http://flameeyes.web.ctonet.it/mirror/${P}.tar.bz2"
HOMEPAGE="http://www.nemohackers.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="|| ( kde-base/kopete >=kde-base/kdenetwork-3.2 )"
need-kde 3.2