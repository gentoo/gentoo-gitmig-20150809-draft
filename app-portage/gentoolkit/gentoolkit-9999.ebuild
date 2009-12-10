# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoolkit/gentoolkit-9999.ebuild,v 1.4 2009/12/10 20:52:22 fuzzyray Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils subversion

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
	dev-lang/python[xml]
	dev-lang/perl
	sys-apps/grep
	sys-apps/gawk"
RDEPEND="${DEPEND}
	app-misc/realpath"
RESTRICT_PYTHON_ABIS="3.*"

distutils_src_compile_pre_hook() {
	echo VERSION="9999-r${ESVN_WC_REVISION}" "$(PYTHON)" setup.py set_version
	VERSION="9999-r${ESVN_WC_REVISION}" "$(PYTHON)" setup.py set_version
}

src_compile() {
	subversion_wc_info
	distutils_src_compile
}

src_install() {
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
	elog "The default location for revdep-rebuild files has been moved"
	elog "to /var/cache/revdep-rebuild when run as root."
	einfo
	einfo "Another alternative to equery is app-portage/portage-utils"
	einfo
	einfo "For further information on gentoolkit, please read the gentoolkit"
	einfo "guide: http://www.gentoo.org/doc/en/gentoolkit.xml"
	einfo
}
