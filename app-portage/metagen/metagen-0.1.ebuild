# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/metagen/metagen-0.1.ebuild,v 1.1 2004/08/23 05:26:03 pythonhead Exp $

DESCRIPTION="metadata.xml generator for ebuilds"
HOMEPAGE="http://abeni.sourceforge.net/metagen.html"
SRC_URI="mirror://sourceforge/abeni/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=">=dev-python/jaxml-3.01"

src_install() {
	exeinto /usr/bin
	doexe metagen
	doman metagen.1.gz
}
