# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/videoteco/videoteco-4.69.ebuild,v 1.4 2003/09/05 23:05:05 msterret Exp $

inherit eutils

DESCRIPTION="Enhanced Visual TECO clone"
HOMEPAGE="ftp://ftp.mindlink.net/pub/teco/cantrell-teco/"
SRC_URI="ftp://ftp.mindlink.net/pub/teco/cantrell-teco/teco_4_69.tar.gz
	ftp://ftp.mindlink.net/pub/teco/cantrell-teco/unofficial_patches/4.69/patch1"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha x86"

DEPEND="virtual/glibc
	sys-libs/libtermcap-compat"

S=${WORKDIR}/teco_4_69

src_compile() {
	epatch ${FILESDIR}/teco_linux_gcc3.patch
	epatch ${DISTDIR}/patch1
	emake || die "compilation failed"
}

src_install() {
	insinto /usr/bin
	dobin teco
	dodoc README RELEASE_NOTES
}
