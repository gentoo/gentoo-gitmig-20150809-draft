# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/metamail/metamail-2.7.53.3.ebuild,v 1.9 2009/12/15 18:22:23 armin76 Exp $

WANT_AUTOCONF="2.5"

inherit eutils versionator autotools

MY_PV=$(get_version_component_range 1-2)
DEB_PV=${MY_PV}-$(get_version_component_range 3)

DESCRIPTION="Metamail (with Debian patches) - Generic MIME package"
HOMEPAGE="ftp://thumper.bellcore.com/pub/nsb/"
SRC_URI="ftp://thumper.bellcore.com/pub/nsb/mm${MY_PV}.tar.Z
	mirror://debian/pool/main/m/metamail/metamail_${DEB_PV}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="sys-libs/ncurses
	app-arch/sharutils
	net-mail/mailbase"
RDEPEND="app-misc/mime-types
	sys-apps/debianutils"

S=${WORKDIR}/mm${MY_PV}/src

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/metamail_${DEB_PV}.diff
	epatch "${FILESDIR}"/${PN}-2.7.45.3-CVE-2006-0709.patch
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
	eautoreconf
	chmod +x "${S}"/configure
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc COPYING CREDITS README
	rm man/mmencode.1
	doman man/* debian/mimencode.1 debian/mimeit.1
}
