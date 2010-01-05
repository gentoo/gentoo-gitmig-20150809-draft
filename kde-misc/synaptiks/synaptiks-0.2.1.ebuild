# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/synaptiks/synaptiks-0.2.1.ebuild,v 1.1 2010/01/05 12:40:55 ssuominen Exp $

EAPI=2
KDE_LINGUAS="da de en_GB ru tr"
inherit kde4-base

DESCRIPTION="A touchpad tool for KDE"
HOMEPAGE="http://synaptiks.lunaryorn.de/"
SRC_URI="http://bitbucket.org/lunar/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND="x11-libs/libXi"

DOCS="CHANGES README"
