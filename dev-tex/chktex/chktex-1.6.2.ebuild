# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/chktex/chktex-1.6.2.ebuild,v 1.4 2004/10/17 10:01:05 absinthe Exp $

DESCRIPTION="Checks latex source for common mistakes"
HOMEPAGE="http://www.nongnu.org/chktex/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
# The ebuild relies on the appropriate tarball on the gentoo mirrors:
# If not yet available, do the following:
# - Download from ftp://ftp.dante.de/tex-archive/support/chktex.tar.gz
# - move the tarball to /usr/portage/distfiles/chktex-1.6.2.tar.gz

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"
IUSE="debug"

DEPEND="virtual/tetex
	dev-lang/perl
	sys-apps/groff
	dev-tex/latex2html"

S="${WORKDIR}/${PN}"

src_compile() {
	chmod +x configure || die "change configure script permission failed"
	econf `use_enable debug debug-info` || die
	emake || die
}

src_install() {
	einstall || die
	dodoc COPYING SCOPTIONS
}
