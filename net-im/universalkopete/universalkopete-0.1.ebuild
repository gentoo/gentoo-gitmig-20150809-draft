# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/universalkopete/universalkopete-0.1.ebuild,v 1.1 2004/03/15 21:19:34 humpback Exp $

inherit kde
need-kde 3.2

S=${WORKDIR}/universalkopete

DESCRIPTION="Allows Kopete to embed into the Universal Sidebar and become part\
			of your KDE desktop as opposed to a floating window."
SRC_URI="http://www.nemohackers.org/software/universalkopete/${P}.tar.bz2
		http://flameeyes.web.ctonet.it/mirror/${P}.tar.bz2"

HOMEPAGE="http://www.nemohackers.org/"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND=">=kde-base/kdenetwork-3.2_rc1"
