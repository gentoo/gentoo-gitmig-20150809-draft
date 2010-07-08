# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/qct/qct-1.7.ebuild,v 1.8 2010/07/08 12:38:15 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="PyQt based commit tool for many VCSs"
HOMEPAGE="http://qct.sourceforge.net/"
SRC_URI="http://qct.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bazaar cvs mercurial monotone subversion"

DEPEND="app-text/asciidoc
	app-text/xmlto
	dev-python/PyQt4
	bazaar? ( dev-vcs/bzr )
	cvs? ( dev-vcs/cvs )
	mercurial? ( dev-vcs/mercurial )
	monotone? ( dev-vcs/monotone )
	subversion? ( dev-vcs/subversion )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

PYTHON_MODNAME="qctlib"

src_prepare() {
	distutils_src_prepare

	rm qctlib/vcs/p4.py

	# support for git requires cogito which isn't in portage
	rm qctlib/vcs/git.py
	rm qctlib/vcs/cg.py

	use bazaar || rm qctlib/vcs/bzr.py
	use cvs || rm qctlib/vcs/cvs.py
	use mercurial || rm qctlib/vcs/hg.py
	use monotone || rm qctlib/vcs/mtn.py
	use subversion || rm qctlib/vcs/svn.py
}

src_install() {
	distutils_src_install

	# manpage and html docs are built using asciidoc
	make -C doc man html || die
	doman doc/qct.1 || die
	dohtml doc/qct.1.html || die

	if use bazaar; then
		insinto "$(python_get_sitedir)/bzrlib/plugins" || die
		doins plugins/qctBzrPlugin.py || die
	fi

	if use mercurial; then
		insinto "$(python_get_sitedir)/hgext" || die
		doins hgext/qct.py || die
		insinto /etc/mercurial/hgrc.d || die
		doins "${FILESDIR}/qct.rc" || die
	fi
}
