# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kopete-ktts/kopete-ktts-1.3.0.ebuild,v 1.4 2009/02/16 07:24:23 tampakrap Exp $

ARTS_REQUIRED="never"

inherit kde

MY_P=${P/-/_}

DESCRIPTION="A Text-to-Speech plugin for the Kopete KDE Instant Messenger."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=30900"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/30900-${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( =kde-base/kttsd-3.5* =kde-base/kdeaccessibility-3.5* )
		|| (  =kde-base/kopete-3.5* =kde-base/kdenetwork-3.5* )"
RDEPEND="${DEPEND}"

need-kde 3.5

S="${WORKDIR}/${MY_P}"
