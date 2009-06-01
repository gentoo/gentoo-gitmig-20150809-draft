# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/dolphin/dolphin-0.8.2-r1.ebuild,v 1.4 2009/06/01 15:54:51 nixnut Exp $

EAPI="2"

ARTS_REQUIRED="never"

USE_KEG_PACKAGING="1"

LANGS="de es et fr he it ru pl"

inherit kde

DESCRIPTION="A file manager for KDE focusing on usability."
HOMEPAGE="http://enzosworld.gmxhome.de/"
SRC_URI="http://enzosworld.gmxhome.de/download/${P}.tar.gz"

KEYWORDS="amd64 ppc x86 ~x86-fbsd"

SLOT="3.5"
LICENSE="GPL-2"
IUSE="kdeenablefinal"

need-kde 3.5

PATCHES=( "${FILESDIR}/${P}-tarZip-handlers.patch" )
