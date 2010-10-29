# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kding/kding-0.6.ebuild,v 1.4 2010/10/29 12:48:37 ssuominen Exp $

EAPI=2
KDE_LINGUAS="de"
inherit kde4-base

DESCRIPTION="KDing is a KDE port of Ding, a dictionary lookup program."
HOMEPAGE="http://www.rexi.org/software/kding/"
SRC_URI="http://www.rexi.org/downloads/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug +handbook"

PATCHES=( "${FILESDIR}"/${P}-dtd.patch )
