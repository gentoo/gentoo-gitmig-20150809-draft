# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/symlinks/symlinks-1.2-r2.ebuild,v 1.4 2007/12/11 08:36:49 pva Exp $

inherit flag-o-matic eutils toolchain-funcs

DESCRIPTION="Symlinks scans for and fixes broken or messy symlinks"
HOMEPAGE="http://www.ibiblio.org/pub/linux/utils/file/"
SRC_URI="http://www.ibiblio.org/pub/linux/utils/file/${P}.tar.gz
	mirror://debian/pool/main/s/symlinks/${P/-/_}-4.1.diff.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 sparc x86"
IUSE="static"

src_unpack() {
	unpack ${A}

	# bugfixes from the debian project.
	epatch "${DISTDIR}"/${P/-/_}-4.1.diff.gz
	epatch "${FILESDIR}"/${P}-fix-implicit-declaration.patch
}

src_compile() {
	# could be useful if being used to repair
	# symlinks that are preventing shared libraries from
	# functioning.
	use static && append-flags -static
	emake CC=$(tc-getCC) || die
}

src_install() {
	dobin symlinks || die
	doman symlinks.8
	dodoc symlinks.lsm
}
