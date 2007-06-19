# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kopete-ktts/kopete-ktts-1.3.0.ebuild,v 1.1 2007/06/19 17:02:30 philantrop Exp $

inherit kde

MY_P=${P/-/_}

DESCRIPTION="A Text-to-Speech plugin for the Kopete KDE Instant Messenger"
HOMEPAGE="http://conrausch.elise.no-ip.com/index.php?p=kopete_ktts"
SRC_URI="http://conrausch.elise.no-ip.com/kopete/ktts/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( kde-base/kttsd kde-base/kdeaccessibility )
		|| ( kde-base/kopete kde-base/kdenetwork )"
RDEPEND="${DEPEND}"

need-kde 3

S="${WORKDIR}/${MY_P}"
