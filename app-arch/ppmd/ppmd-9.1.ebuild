# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/ppmd/ppmd-9.1.ebuild,v 1.1 2003/11/15 08:52:28 seemant Exp $

inherit eutils

IUSE=""

PATCHV="7"
MY_P=${P/-/_}
MY_S=${PN}-i1
S=${WORKDIR}/${MY_S}
DESCRIPTION="PPM based compressor -- better behaved than bzip2"
HOMEPAGE="http://http.us.debian.org/debian/pool/main/p/ppmd/"
SRC_URI="http://http.us.debian.org/debian/pool/main/p/ppmd/${MY_P}.orig.tar.gz
	http://http.us.debian.org/debian/pool/main/p/ppmd/${MY_P}-${PATCHV}.diff.gz"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~amd64 ~ia64"

DEPEND="app-arch/gzip
	sys-devel/patch"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${MY_P}-${PATCHV}.diff
	chmod +x ${S}/configure
}

src_install() {
	einstall || die
	doman ${S}/PPMd.1
	dodoc ${S}/read_me.txt
}
