# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylirc/pylirc-0.0.4.ebuild,v 1.5 2004/09/11 09:59:05 blubb Exp $

inherit distutils

DESCRIPTION="lirc module for Python."
HOMEPAGE="http://sourceforge.net/projects/pylirc/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="${DEPEND}
	app-misc/lirc"
