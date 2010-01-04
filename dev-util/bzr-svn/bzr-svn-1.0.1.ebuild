# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bzr-svn/bzr-svn-1.0.1.ebuild,v 1.2 2010/01/04 10:52:32 fauli Exp $

EAPI=2

inherit distutils

MY_P=${P/_rc/~rc}

DESCRIPTION="Bazaar plugin that adds support for foreign Subversion repositories."
HOMEPAGE="http://bazaar-vcs.org/BzrForeignBranches/Subversion"
SRC_URI="http://samba.org/~jelmer/bzr/${MY_P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

# Packager: check compatible bzr versions via
# `grep bzr_compatible_versions info.py`, and minimum subvertpy version
# via `grep subvertpy_minimum_version info.py`.

#=dev-util/bzr-1.16*
#		=dev-util/bzr-1.17*
DEPEND="
	|| ( =dev-util/bzr-2.1*
		=dev-util/bzr-2.0*
		=dev-util/bzr-1.18*
		=dev-util/bzr-1.17*
		=dev-util/bzr-1.16* )
	>=dev-lang/python-2.5[sqlite]
	>=dev-python/subvertpy-0.6.1"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS FAQ HACKING NEWS README TODO UPGRADING mapping.txt specs/*"
