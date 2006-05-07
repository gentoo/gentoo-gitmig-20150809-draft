# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/rsibreak/rsibreak-0.6.0.ebuild,v 1.2 2006/05/07 18:29:52 flameeyes Exp $

USE_KEG_PACKAGING="yes"

LANGS="bg br ca da el en_GB es ga gl it nl pl pt sr sr@Latn sv tr"

inherit kde

MY_P="${PN/rsi/Rsi}-${PV/_rc/-rc}"

DESCRIPTION="A small utility which bothers you at certain intervals"
SRC_URI="http://www.rsibreak.org/images/1/1b/${MY_P}.tar.bz2"
HOMEPAGE="http://www.rsibreak.org/"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

S="${WORKDIR}/${PN}-${PV/_rc/-rc}"

RDEPEND="|| ( (
			x11-libs/libXext
			x11-libs/libX11
			x11-libs/libXScrnSaver
		) virtual/x11 )"

DEPEND="${RDEPEND}
	|| ( (
			x11-proto/xextproto
			x11-proto/xproto
			x11-proto/scrnsaverproto
		) virtual/x11 )"

need-kde 3.3

