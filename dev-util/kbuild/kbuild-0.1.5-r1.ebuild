# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kbuild/kbuild-0.1.5-r1.ebuild,v 1.9 2010/06/22 18:40:19 arfrever Exp $

EAPI=2

WANT_AUTOMAKE=1.9

inherit eutils autotools

MY_P=kBuild-${PV}-src-20090221
DESCRIPTION="A makefile framework for writing simple makefiles for complex tasks"
HOMEPAGE="http://svn.netlabs.org/kbuild/wiki"
SRC_URI="http://gentoo.zerodev.it/files/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-vcs/cvs
	dev-vcs/subversion
	sys-devel/gettext"
RDEPEND=""

S=${WORKDIR}/${MY_P/-src-20090221}

src_prepare() {
	rm -rf "${S}/kBuild/bin"

	epatch "${FILESDIR}/${PN}-unknown-configure-opt.patch"
	epatch "${FILESDIR}/${PN}-glibc-2.10.patch"
	epatch "${FILESDIR}/${PN}-0.1.5-gentoo-docdir.patch"

	cd "${S}/src/kmk"
	eautoreconf
	cd "${S}/src/sed"
	eautoreconf
}

src_compile() {
	kBuild/env.sh --full make -f bootstrap.gmk AUTORECONF=true \
		|| die "bootstrap failed"
}

src_install() {
	kBuild/env.sh kmk NIX_INSTALL_DIR=/usr PATH_INS="${D}" install \
		|| die "install failed"
}
