# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/sextractor/sextractor-2.5.0.ebuild,v 1.1 2009/02/17 20:44:23 bicatali Exp $

EAPI=2
inherit toolchain-funcs flag-o-matic

DESCRIPTION="Extract catalogs of sources from astronomical FITS images."
HOMEPAGE="http://terapix.iap.fr/soft/sextractor"
SRC_URI="ftp://ftp.iap.fr/pub/from_users/bertin/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
DEPEND=""
RDEPEND=""

src_configure() {
	CONFDIR=/usr/share/${PN}/config
	# change default configuration files location from current dir
	sed -i -e "s:default\.:${CONFDIR}/default\.:" src/preflist.h || die
	# buggy with >= O2
	replace-flags -O[2-9] -O1
	local myconf
	[[ "$(tc-getCC)" == "icc" ]] & myconf="${myconf} --enable-icc"
	econf "${myconf}" || die "econf failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog HISTORY README THANKS
	insinto ${CONFDIR}
	doins config/* || die
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins doc/*
	fi
}

pkg_postinst() {
	elog "SExtractor configuration files are located"
	elog "in ${CONFDIR} and loaded by default."
}
