# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylirc/pylirc-0.0.5.ebuild,v 1.5 2009/12/16 21:14:22 maekke Exp $

inherit distutils

DESCRIPTION="lirc module for Python."
HOMEPAGE="http://sourceforge.net/projects/pylirc/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="${DEPEND}
	app-misc/lirc"
