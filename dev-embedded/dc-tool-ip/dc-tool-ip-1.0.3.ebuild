# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/dc-tool-ip/dc-tool-ip-1.0.3.ebuild,v 1.3 2004/06/29 13:22:06 vapier Exp $

DESCRIPTION="ethernet program loader for the Dreamcast"
HOMEPAGE="http://adk.napalm-x.com/dc/dcload-ip/"
SRC_URI="http://adk.napalm-x.com/dc/dcload-ip/${P}-linux.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}

src_install() {
	into /opt
	newbin ${P}-linux ${PN} || die
}
