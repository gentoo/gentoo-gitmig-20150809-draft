# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/klogic/klogic-1.61.ebuild,v 1.1 2004/12/27 19:49:17 ribosome Exp $

inherit kde

DESCRIPTION="KLogic is an application for easy creation and simulation of electrical circuits"
HOMEPAGE="http://www.a-rostin.de/klogic/"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
SRC_URI="http://www.a-rostin.de/klogic/Version/${P}.tar.gz"
LICENSE="GPL-2"


need-kde 3
