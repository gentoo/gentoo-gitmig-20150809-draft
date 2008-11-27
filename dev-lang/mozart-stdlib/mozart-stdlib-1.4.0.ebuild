# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mozart-stdlib/mozart-stdlib-1.4.0.ebuild,v 1.2 2008/11/27 05:35:34 keri Exp $

inherit eutils

MY_P="mozart-${PV}.20080704-std"

DESCRIPTION="The Mozart Standard Library"
HOMEPAGE="http://www.mozart-oz.org/"
SRC_URI="http://www.mozart-oz.org/download/mozart-ftp/store/1.4.0-2008-07-02-tar/mozart-1.4.0.20080704-std.tar.gz"
LICENSE="Mozart"

SLOT="0"
KEYWORDS="-amd64 ~ppc -ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND="dev-lang/mozart"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-ozload.patch
}

src_compile() {
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake -j1 \
		PREFIX="${D}"/usr/lib/mozart \
		install || die "emake install failed"

	dosym /usr/lib/mozart/bin/ozmake /usr/bin/ozmake

	if use doc ; then
		dohtml -r *
	fi

	doman ozmake/ozmake.1
	dodoc ozmake/{CHANGES,DESIGN,NOTES,README}
}
