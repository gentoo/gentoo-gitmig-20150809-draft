# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kshutdown/kshutdown-2.0_beta12.ebuild,v 1.1 2011/02/16 15:29:49 scarabeus Exp $

EAPI=3

KDE_LINGUAS="ar bg cs da de el es fr hu it nb nl pl pt_BR ru sk sr@Latn sr sv tr zh_CN"
inherit kde4-base

MY_P=${PN}-source-${PV/_}

DESCRIPTION="A shutdown manager for KDE"
HOMEPAGE="http://kshutdown.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep libkworkspace)
"
DEPEND="${RDEPEND}
	app-arch/unzip
"

S=${WORKDIR}/${P/_}
