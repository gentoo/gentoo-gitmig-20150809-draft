# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/bitbake/bitbake-0.ebuild,v 1.3 2005/03/08 23:35:48 vapier Exp $

ESVN_REPO_URI="svn://svn.berlios.de/bitbake/trunk/bitbake"
inherit subversion eutils

DESCRIPTION="package management tool for OpenEmbedded"
HOMEPAGE="http://developer.berlios.de/projects/bitbake/"
SRC_URI="http://www.frankengul.org/~seb/cowbb/bbcow9b.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="vanilla"

DEPEND="dev-lang/python"

src_unpack() {
	subversion_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-gentoo-paths.patch
	use vanilla || epatch "${DISTDIR}"/bbcow9b.patch
}

src_install() {
	python setup.py install --root="${D}" || die "setup failed"
}
