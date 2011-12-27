# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/alot/alot-0.21-r1.ebuild,v 1.1 2011/12/27 11:23:56 aidecoe Exp $

EAPI=4

PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[456] 3.*"

inherit distutils

DESCRIPTION="Experimental terminal UI for net-mail/notmuch written in Python"
HOMEPAGE="https://github.com/pazz/alot"
SRC_URI="${HOMEPAGE}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-python/twisted
	>=dev-python/urwid-1.0.0
	net-mail/mailbase
	net-mail/notmuch[crypt,python]
	sys-apps/file[python]
	"

DOCS="CUSTOMIZE FAQ"

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_prepare() {
	distutils_src_prepare

	local md
	for md in *.md; do
		mv "${md}" "${md%.md}"
	done

	echo "${PV}" > alot/VERSION
}
