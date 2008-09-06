# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kbuild/kbuild-0.1.3.ebuild,v 1.2 2008/09/06 20:18:51 mr_bones_ Exp $

EAPI=1

WANT_AUTOMAKE=1.9

inherit eutils autotools

MY_P=kBuild-${PV}-src
DESCRIPTION="A makefile framework for writing simple makefiles for complex tasks"
HOMEPAGE="http://svn.netlabs.org/kbuild/wiki"
SRC_URI="ftp://ftp.netlabs.org/pub/kbuild/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/yacc
		dev-util/cvs"

S=${WORKDIR}/${MY_P/-src}

src_unpack() {
		unpack ${A}
		cd "${S}"

		rm -rf "${S}/kBuild/bin"
}

src_compile() {
		kBuild/env.sh --full \
		make -f bootstrap.gmk || die "bootstrap failed"
}

src_install() {
		kBuild/env.sh kmk \
		NIX_INSTALL_DIR=/usr \
		PATH_INS="${D}" \
		install || die "install failed"
}
