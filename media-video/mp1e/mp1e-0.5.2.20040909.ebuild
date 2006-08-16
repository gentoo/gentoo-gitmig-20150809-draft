# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mp1e/mp1e-0.5.2.20040909.ebuild,v 1.1 2006/08/16 11:28:34 zzam Exp $

inherit eutils toolchain-funcs

MY_P=rte-09sep04

DESCRIPTION="Stand alone mpeg-encoder mp1e from rte"
HOMEPAGE="http://zapping.sourceforge.net/Zapping/index.html"
SRC_URI="http://www.akool.homepage.t-online.de/analogtv/download/${MY_P}.tar.bz2
		mirror://vdrfiles/${PN}/${MY_P}-mp1e-gentoo.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="!<=media-plugins/vdr-analogtv-0.9.37"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}/mp1e

pkg_setup() {
	if [ "$(gcc-major-version)" == "4" ]; then
		eerror "this mp1e-version requires gcc-3 in order to build correctly"
		eerror "please compile it with gcc-3"
		die "gcc 4 cannot build this mp1e-version"
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	einfo "Applying vdr-analogtv patch:"
	epatch ${DISTDIR}/${MY_P}-mp1e-gentoo.patch
}

src_compile() {
	libtoolize --copy --force

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	cd ${S}
	doman mp1e.1

	dodoc BUGS ChangeLog
	dobin mp1e
}

