# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-sv/ispell-sv-1.3.8.ebuild,v 1.5 2004/03/14 00:27:41 mr_bones_ Exp $

DESCRIPTION="The Swedish dictionary for ispell"
HOMEPAGE="http://sv.speling.org"
SRC_URI="http://sv.speling.org/filer/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="ppc x86 sparc alpha mips hppa"
IUSE=""

DEPEND="app-text/ispell"

src_compile() {
	# It's important that we export the TMPDIR environment variable,
	# so we don't commit sandbox violations
	export TMPDIR=/tmp
	emake || die
	unset TMPDIR
}

src_install () {
	insinto /usr/lib/ispell
	doins svenska.aff svenska.hash
	dodoc README contributors COPYING Copyright
}
