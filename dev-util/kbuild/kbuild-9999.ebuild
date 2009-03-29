# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kbuild/kbuild-9999.ebuild,v 1.1 2009/03/29 09:47:27 patrick Exp $

EAPI=2

WANT_AUTOMAKE=1.9

inherit autotools eutils subversion

DESCRIPTION="A makefile framework for writing simple makefiles for complex tasks"
HOMEPAGE="http://svn.netlabs.org/kbuild/wiki"
ESVN_REPO_URI="http://svn.netlabs.org/repos/kbuild/trunk"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-devel/gettext"
RDEPEND=""

S=${WORKDIR}/${MY_P/-src}

src_prepare() {
		rm -rf "${S}/kBuild/bin"

		cd "${S}/src/kmk"
		eautoreconf
		cd "${S}/src/sed"
		eautoreconf
}

src_compile() {
		kBuild/env.sh --full \
		make -f bootstrap.gmk AUTORECONF=true \
		|| die "bootstrap failed"
}

src_install() {
		kBuild/env.sh kmk \
		NIX_INSTALL_DIR=/usr \
		PATH_INS="${D}" \
		install || die "install failed"
}
