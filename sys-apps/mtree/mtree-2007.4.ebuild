# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mtree/mtree-2007.4.ebuild,v 1.4 2009/02/09 22:16:21 maekke Exp $

inherit flag-o-matic eutils

MY_PV=${PV/./Q}
DESCRIPTION="check the permissions of a file system against a spec file"
HOMEPAGE="http://www.netbsd.org/"
SRC_URI="ftp://ftp.netbsd.org/pub/pkgsrc/pkgsrc-${MY_PV}/pkgsrc-${MY_PV}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc ~s390 x86"
IUSE=""

S=${WORKDIR}/pkgsrc/pkgtools

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}+glibc-2.8.patch"
}

src_compile() {
	cd "${S}"/libnbcompat/files
	econf || die "econf libnbcompat failed"
	# workaround weak makefile dependencies
	emake nbcompat/nbtypes.h || die "emake nbcompat/nbtypes.h failed"
	emake || die "emake libnbcompat failed"
	cd "${S}"/mtree/files
	append-cppflags -I../../libnbcompat/files
	LIBS=../../libnbcompat/files/libnbcompat.a \
	econf || die "econf mtree failed"
	emake || die "emake mtree failed"
}

src_install() {
	cd mtree/files
	dosbin mtree || die
	doman mtree.8
}
