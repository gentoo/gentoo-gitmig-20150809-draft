# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mmv/mmv-1.01b.ebuild,v 1.11 2004/10/26 13:40:41 ka0ttic Exp $

inherit eutils gcc toolchain-funcs

DESCRIPTION="Move/copy/append/link multiple files according to a set of wildcard patterns."
HOMEPAGE="http://packages.debian.org/unstable/utils/mmv.html"

PATCH_DEB_VER="12"

SRC_URI="mirror://debian/pool/main/m/mmv/${P/-/_}.orig.tar.gz
	mirror://debian/pool/main/m/mmv/${P/-/_}-${PATCH_DEB_VER}.diff.gz"

LICENSE="freedist"
SLOT="0"

KEYWORDS="x86 amd64"
IUSE=""

S=${WORKDIR}/${P}.orig

src_unpack() {
	unpack ${P/-/_}.orig.tar.gz
	epatch ${DISTDIR}/${P/-/_}-${PATCH_DEB_VER}.diff.gz

	#apply both patches to compile with gcc-3.4 closing bug #62711
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		epatch ${FILESDIR}/mmv-gcc34.patch
	fi

}

src_compile() {
	mmv_CFLAGS=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"

	emake CC="$(tc-getCC)" CFLAGS="${mmv_CFLAGS} ${CFLAGS} " LDFLAGS=" -s " || die
}

src_install() {

	dobin mmv
	dosym /usr/bin/mmv /usr/bin/mcp
	dosym /usr/bin/mmv /usr/bin/mln
	dosym /usr/bin/mmv /usr/bin/mad

	doman mmv.1
	dosym mmv.1.gz /usr/share/man/man1/mcp.1.gz
	dosym mmv.1.gz /usr/share/man/man1/mln.1.gz
	dosym mmv.1.gz /usr/share/man/man1/mad.1.gz

	newdoc ANNOUNCE README
	cd debian
	dodoc changelog control copyright
}

