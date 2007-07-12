# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mp1e/mp1e-0.5.2.20040909.ebuild,v 1.5 2007/07/12 02:40:43 mr_bones_ Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils toolchain-funcs autotools

MY_P=rte-09sep04

DESCRIPTION="Stand alone mpeg-encoder mp1e from rte"
HOMEPAGE="http://zapping.sourceforge.net/Zapping/index.html"
SRC_URI="http://www.akool.homepage.t-online.de/analogtv/download/${MY_P}.tar.bz2
		mirror://vdrfiles/${PN}/${MY_P}-mp1e-gentoo.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="!<=media-plugins/vdr-analogtv-0.9.37"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}/mp1e

pkg_setup() {
	if [ "$(gcc-major-version)" == "4" ]; then
		eerror "this mp1e-version requires gcc-3 in order to build correctly"

		# Search gcc-3
		local MY_GCC=$(ls -1 /usr/bin/gcc-3.* 2>/dev/null|sort -r|head -1)
		MY_GCC=${MY_GCC##*/}

		if [[ -n ${MY_GCC} ]]; then
			eerror "please compile it using:"
			eerror "\tCC=${MY_GCC} emerge mp1e"
		else
			eerror "please install a gcc-3.* and try using it for ${PN}:"
			eerror "\temerge =gcc-3*"
		fi
		die "gcc 4 cannot build this mp1e-version"
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	einfo "Applying vdr-analogtv patch:"
	epatch ${DISTDIR}/${MY_P}-mp1e-gentoo.patch

	AT_M4DIR="macros" eautoreconf
}

src_install() {
	cd ${S}
	doman mp1e.1

	dodoc BUGS ChangeLog
	dobin mp1e
}
