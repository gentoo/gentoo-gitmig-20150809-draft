# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/symlinks/symlinks-1.2.ebuild,v 1.1 2003/05/24 22:10:56 taviso Exp $

inherit flag-o-matic

DESCRIPTION="Symlinks scans for and fixes broken or messy symlinks"
HOMEPAGE="http://www.ibiblio.org/pub/linux/utils/file/"
SRC_URI="http://www.ibiblio.org/pub/linux/utils/file/${P}.tar.gz
	http://ftp.debian.org/debian/pool/main/s/symlinks/symlinks_1.2-4.1.diff.gz"

LICENSE="freedist"
SLOT="0"

KEYWORDS="~x86 ~alpha"

IUSE="static"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_compile() {
	epatch ${DISTDIR}/symlinks_1.2-4.1.diff.gz || die "patching failed"
	
	# could be useful if being used to repair
	# symlinks that are preventing shared libraries from
	# functioning.
	# 
	
	use static && append-flags -static
	
	emake || die
}

src_install() {
	dobin symlinks
	doman symlinks.8
	dodoc symlinks.lsm
}
