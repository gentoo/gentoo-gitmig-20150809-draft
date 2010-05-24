# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kshutdown/kshutdown-2.0_beta9.ebuild,v 1.3 2010/05/24 11:06:00 phajdan.jr Exp $

EAPI=2
KDE_LINGUAS="ar bg cs de el es fr hu it nb nl pl pt_BR ru sk sr@Latn sr sv tr zh_CN"
inherit kde4-base

MY_P=${PN}-source-${PV/_}

DESCRIPTION="A shutdown manager for KDE"
HOMEPAGE="http://kshutdown.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 ~ppc x86"
IUSE="debug"

RDEPEND=">=kde-base/libkworkspace-${KDE_MINIMAL}
	!${CATEGORY}/${PN}:0"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${P/_}
