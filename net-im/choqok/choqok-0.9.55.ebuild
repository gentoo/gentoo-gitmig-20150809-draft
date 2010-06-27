# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/choqok/choqok-0.9.55.ebuild,v 1.3 2010/06/27 23:59:41 hwoarang Exp $

EAPI="2"

KDE_LINGUAS="bg cs da de el en_GB eo es et fi fr ga gl hr hu is ja km lt ms nb
nds nl pa pl pt pt_BR ro ru sk sv tr uk zh_CN zh_TW"
inherit kde4-base
DESCRIPTION="A Free/Open Source micro-blogging client for KDE"
HOMEPAGE="http://choqok.gnufolks.org/"
SRC_URI="http://dev.gentooexperimental.org/~scarabeus/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

PATCHES=(
	"${FILESDIR}"/${P}_qt47.patch
)
