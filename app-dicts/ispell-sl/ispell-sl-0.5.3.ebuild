# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-sl/ispell-sl-0.5.3.ebuild,v 1.1 2005/11/15 22:35:26 arj Exp $

inherit rpm

DESCRIPTION="The Slovenian dictionary for ispell"
HOMEPAGE="http://nl.ijs.si/GNUsl/download/ispell/"
SRC_URI="http://nl.ijs.si/GNUsl/download/ispell/ispell-sl-0.5-3.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-text/ispell"

src_compile() {
	# It's important that we export the TMPDIR environment variable,
	# so we don't commit sandbox violations
	export TMPDIR=/tmp
	cd ${WORKDIR}
	buildhash mte-sl.munched slovensko.aff slovensko.hash || die "Failed to create hash file"
	unset TMPDIR
}

src_install() {
	insinto /usr/lib/ispell
	doins ${WORKDIR}/slovensko.aff ${WORKDIR}/slovensko.hash
	dodoc ${WORKDIR}/README
}
