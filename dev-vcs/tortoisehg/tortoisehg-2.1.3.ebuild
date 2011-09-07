# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/tortoisehg/tortoisehg-2.1.3.ebuild,v 1.1 2011/09/07 02:33:42 floppym Exp $

EAPI=3

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2:2.5"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils eutils multilib

DESCRIPTION="Set of graphical tools for Mercurial"
HOMEPAGE="http://tortoisehg.bitbucket.org"
SRC_URI="http://bitbucket.org/${PN}/targz/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc nautilus"

RDEPEND="dev-python/iniparse
	dev-python/pygments
	dev-python/PyQt4
	dev-python/qscintilla-python
	>=dev-vcs/mercurial-1.9
	nautilus? ( dev-python/nautilus-python )"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-1.0.3 )"

src_prepare() {
	# make the install respect multilib.
	sed -i -e "s:lib/nautilus:$(get_libdir)/nautilus:" setup.py || die
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile

	if use doc ; then
		emake -C doc html || die
	fi
}

src_install() {
	distutils_src_install
	dodoc doc/ReadMe*.txt doc/TODO || die

	if use doc ; then
		dohtml -r doc/build/html || die
	fi

	insinto /usr/share/icons/hicolor/scalable/apps
	newins icons/scalable/apps/thg-logo.svg tortoisehg_logo.svg || die
	domenu contrib/${PN}.desktop || die

	if ! use nautilus; then
		rm -rf "${ED}usr/$(get_libdir)/nautilus" || die
	fi
}
