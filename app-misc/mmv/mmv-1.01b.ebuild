# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mmv/mmv-1.01b.ebuild,v 1.3 2003/09/05 12:10:36 msterret Exp $

# orig.tar.gz and debian-diff contains an underscore in the name
# whereas the other files (including the unpacked sources)
# contain a minus sign !!

inherit eutils


DESCRIPTION="Move/copy/append/link multiple files according to a set of wildcard patterns."
HOMEPAGE=" http://packages.debian.org/unstable/utils/mmv.html"

PATCH_DEB_VER="12"
_P="${PN}_${PV}"

SRC_URI="http://ftp.debian.org/debian/pool/main/m/mmv/${_P}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/m/mmv/${_P}-${PATCH_DEB_VER}.diff.gz"

LICENSE="freedist"
SLOT="0"

KEYWORDS="x86"

S=${WORKDIR}/${P}.orig

src_unpack() {
	unpack ${_P}.orig.tar.gz
	epatch ${DISTDIR}/${_P}-${PATCH_DEB_VER}.diff.gz
}

src_compile() {
	mmv_CFLAGS=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"

	emake CC="gcc " CFLAGS="${mmv_CFLAGS} ${CFLAGS} " LDFLAGS=" -s " || die
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

