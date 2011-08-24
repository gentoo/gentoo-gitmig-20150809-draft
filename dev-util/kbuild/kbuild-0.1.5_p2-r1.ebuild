# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kbuild/kbuild-0.1.5_p2-r1.ebuild,v 1.4 2011/08/24 19:21:46 maekke Exp $

EAPI=2

WANT_AUTOMAKE=1.9

inherit eutils autotools

MY_P=kBuild-${PV/_/-}-src
DESCRIPTION="A makefile framework for writing simple makefiles for complex tasks"
HOMEPAGE="http://svn.netlabs.org/kbuild/wiki"
SRC_URI="ftp://ftp.netlabs.org/pub/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="sys-devel/gettext
	virtual/yacc"
RDEPEND=""

S=${WORKDIR}/${MY_P/-src}

src_prepare() {
	rm -rf "${S}/kBuild/bin"

	epatch "${FILESDIR}/${PN}-unknown-configure-opt.patch"
	epatch "${FILESDIR}/${PN}-glibc-2.10.patch"
	epatch "${FILESDIR}/${PN}-0.1.5-gentoo-docdir.patch"
	epatch "${FILESDIR}/${P}-qa.patch"

	cd "${S}/src/kmk"
	eautoreconf
	cd "${S}/src/sed"
	eautoreconf

	sed -e "s/_LDFLAGS\.${ARCH}*.*=/& ${LDFLAGS}/g" \
		-i "${S}"/Config.kmk || die #332225
}

src_compile() {
	kBuild/env.sh --full make -f bootstrap.gmk AUTORECONF=true \
		|| die "bootstrap failed"
}

src_install() {
	kBuild/env.sh kmk NIX_INSTALL_DIR=/usr PATH_INS="${D}" install \
		|| die "install failed"
}
