# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/klogic/klogic-1.63.ebuild,v 1.1 2006/07/15 22:22:18 cryos Exp $

inherit kde

DESCRIPTION="KLogic is an application for easy creation and simulation of electrical circuits"
HOMEPAGE="http://www.a-rostin.de/klogic/"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SRC_URI="http://www.a-rostin.de/klogic/Version/${P}.tar.gz"
LICENSE="GPL-2"

need-kde 3
