# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/txt2man/txt2man-1.4.8-r1.ebuild,v 1.2 2005/08/25 03:18:37 agriffis Exp $

inherit eutils

DESCRIPTION="A simple script to convert ASCII text to man page."
HOMEPAGE="http://mvertes.free.fr/"
SRC_URI="mirror://debian/pool/main/t/txt2man/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="app-shells/bash
	sys-apps/gawk"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Escape hyphens and add section info to txt2man manpage
	epatch ${FILESDIR}/${P}-debian.patch
}

src_compile() {
	cd ${S}
	make txt2man.1
}

src_install() {
	cd ${S}

	dobin txt2man
	doman txt2man.1

	dodoc ChangeLog README
}
