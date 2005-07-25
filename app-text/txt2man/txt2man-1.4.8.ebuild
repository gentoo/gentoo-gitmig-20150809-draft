# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/txt2man/txt2man-1.4.8.ebuild,v 1.5 2005/07/25 19:13:23 gustavoz Exp $

DESCRIPTION="A simple script to convert ASCII text to man page."
HOMEPAGE="http://mvertes.free.fr/"
SRC_URI="mirror://debian/pool/main/t/txt2man/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="app-shells/bash
	sys-apps/gawk"
DEPEND="${RDEPEND}"

src_compile() {
	cd ${S}
	gmake txt2man.1
}

src_install() {
	cd ${S}

	dobin txt2man
	doman txt2man.1

	dodoc ChangeLog README
}
