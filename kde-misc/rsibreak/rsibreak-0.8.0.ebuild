# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/rsibreak/rsibreak-0.8.0.ebuild,v 1.2 2006/10/28 23:56:10 flameeyes Exp $

USE_KEG_PACKAGING="yes"

LANGS="ar bg br ca cs da de el en_GB es et fr ga gl it ja ka nl pl pt pt_BR ru sk sr sr@Latn sv tr"

inherit kde

MY_P="${PN/rsi/Rsi}-${PV/_rc/-rc}"

DESCRIPTION="A small utility which bothers you at certain intervals"
SRC_URI="http://www.rsibreak.org/images/e/e0/${MY_P}.tar.bz2"
HOMEPAGE="http://www.rsibreak.org/"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

IUSE=""

S="${WORKDIR}/${PN}-${PV/_rc/-rc}"

RDEPEND="|| ( (
			x11-libs/libXext
			x11-libs/libX11
			x11-libs/libXScrnSaver
		) <virtual/x11-7 )"

DEPEND="${RDEPEND}
	|| ( x11-proto/scrnsaverproto <virtual/x11-7 )"

need-kde 3.3

