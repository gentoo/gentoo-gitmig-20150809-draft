# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit/gentoolkit-9999.ebuild,v 1.11 2010/12/26 13:33:03 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45]"
PYTHON_NONVERSIONED_EXECUTABLES=(".*")

inherit distutils python subversion

ESVN_REPO_URI="svn://anonsvn.gentoo.org/gentoolkit/trunk/gentoolkit"
ESVN_PROJECT="gentoolkit"

DESCRIPTION="Collection of administration scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/tools/index.xml"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS=""

DEPEND="sys-apps/portage
	>=dev-lang/python-2.6[xml]
	!!>=dev-lang/python-2.6[-xml]"
# argparse will need virtual because is also provided by
# dev-lang/python:2.7 and 3.2 or later
# gentoolkit-dev blocker for eshowkw
RDEPEND="${DEPEND}
	!<=app-portage/gentoolkit-dev-0.2.7
	dev-python/argparse
	|| ( app-misc/realpath sys-freebsd/freebsd-bin )
	sys-apps/gawk
	sys-apps/grep"

distutils_src_compile_pre_hook() {
	echo VERSION="9999-r${ESVN_WC_REVISION}" "$(PYTHON)" setup.py set_version
	VERSION="9999-r${ESVN_WC_REVISION}" "$(PYTHON)" setup.py set_version
}

src_compile() {
	subversion_wc_info
	distutils_src_compile
}

src_install() {
	python_convert_shebangs -r "" build-*/scripts-*
	distutils_src_install

	# Create cache directory for revdep-rebuild
	dodir /var/cache/revdep-rebuild
	keepdir /var/cache/revdep-rebuild
	fowners root:root /var/cache/revdep-rebuild
	fperms 0700 /var/cache/revdep-rebuild

	# Can distutils handle this?
	dosym eclean /usr/bin/eclean-dist
	dosym eclean /usr/bin/eclean-pkg
}

pkg_postinst() {
	distutils_pkg_postinst

	# Make sure that our ownership and permissions stuck
	chown root:root "${ROOT}/var/cache/revdep-rebuild"
	chmod 0700 "${ROOT}/var/cache/revdep-rebuild"

	einfo
	einfo "For further information on gentoolkit, please read the gentoolkit"
	einfo "guide: http://www.gentoo.org/doc/en/gentoolkit.xml"
	einfo
	einfo "Another alternative to equery is app-portage/portage-utils"
}
