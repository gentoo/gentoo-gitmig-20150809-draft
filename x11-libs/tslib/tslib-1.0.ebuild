# Copyright 2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/tslib/tslib-1.0.ebuild,v 1.1 2008/05/11 05:58:26 solar Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Touchscreen Access Library"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""
#extras arctic2 collie corgi h3600 linear-h2200 mk712 ucb1x00"
DEPEND=""
RDEPEND=""
HOMEPAGE="http://tslib.berlios.de/"
SRC_URI="mirror://gentoo/${PN}-${PV}-patches-1.tar.bz2 mirror://berlios/${PN}/${PN}-${PV}.tar.bz2"
SLOT="0"
LICENSE="LGPL-2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# patches come from buildroot + openembedded + suse
	epatch "${WORKDIR}"/patches/*.patch
	einfo "Running autogen"
	./autogen.sh
}

src_compile() {
	# compile everything. INSTALL_MASK= what you don't want.
	econf	--enable-linear --enable-dejitter \
		--enable-variance --enable-pthres \
		--enable-input --enable-shared \
		--enable-arctic2 --enable-collie \
		--enable-corgi 	--enable-h3600 \
		--enable-linear-h2200 --enable-mk712 \
		--enable-ucb1x00 --disable-debug || die "Configure failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README
}
