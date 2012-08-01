# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/alot/alot-0.3.1.ebuild,v 1.5 2012/08/01 10:35:11 aidecoe Exp $

EAPI=4

PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[456] 3.*"

inherit distutils vcs-snapshot

DESCRIPTION="Experimental terminal UI for net-mail/notmuch written in Python"
HOMEPAGE="https://github.com/pazz/alot"
SRC_URI="${HOMEPAGE}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="
	doc? ( dev-python/sphinx )
	"
RDEPEND="
	>=dev-python/configobj-4.6.0
	>=dev-python/pyme-0.8.1-r1
	>=dev-python/twisted-10.2.0
	>=dev-python/urwid-1.0.0
	net-mail/mailbase
	>=net-mail/notmuch-0.13[crypt,python]
	sys-apps/file[python]
	"

src_prepare() {
	distutils_src_prepare

	local md
	for md in *.md; do
		mv "${md}" "${md%.md}"
	done
}

src_compile() {
	distutils_src_compile

	if use doc; then
		pushd docs || die
		emake html
		popd || die
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/build/html/*
	fi
}
