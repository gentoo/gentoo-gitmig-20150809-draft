# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/rsibreak/rsibreak-0.8.0-r1.ebuild,v 1.1 2009/10/14 14:41:46 ssuominen Exp $

USE_KEG_PACKAGING="1"

LANGS="ar bg br ca cs da de el en_GB es et fr ga gl it ja ka nl pl pt pt_BR ru sk sr sr@Latn sv tr"
LANGS_DOC="da nl pt sv"
DOC_DIR_SUFFIX="_rsibreak"

inherit kde

MY_P="${PN/rsi/Rsi}-${PV/_rc/-rc}"

DESCRIPTION="A small utility which bothers you at certain intervals"
SRC_URI="http://www.rsibreak.org/images/e/e0/${MY_P}.tar.bz2"
HOMEPAGE="http://www.rsibreak.org/"

LICENSE="GPL-2"
SLOT="3.5"

KEYWORDS="amd64 ppc x86 ~x86-fbsd"

IUSE=""

S="${WORKDIR}/${PN}-${PV/_rc/-rc}"

RDEPEND="x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXScrnSaver"
DEPEND="${RDEPEND}
		x11-proto/scrnsaverproto"

need-kde 3.3
