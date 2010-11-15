# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/offlineimap/offlineimap-6.2.0.2.ebuild,v 1.2 2010/11/15 16:25:13 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils distutils

DESCRIPTION="Powerful IMAP/Maildir synchronization and reader support"
HOMEPAGE="http://wiki.github.com/jgoerzen/offlineimap/"
SRC_URI="mirror://debian/pool/main/o/offlineimap/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc ssl"

DEPEND="doc? ( app-text/docbook-sgml-utils )"
# PYTHON_USE_WITH* don't support this situation. PYTHON_DEPEND in EAPI >=4 maybe will support it.
RDEPEND="=dev-lang/python-2*[threads,ssl?]"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}"/${PN}-6.2.0-darwin10.patch
}

src_compile() {
	distutils_src_compile
	if use doc ; then
		docbook2man offlineimap.sgml || die "building manpage failed"
	fi
}

src_install() {
	distutils_src_install
	dodoc offlineimap.conf offlineimap.conf.minimal
	if use doc ; then
		doman offlineimap.1 || die "installing manpage failed"
	fi
}

pkg_postinst() {
	distutils_pkg_postinst

	elog ""
	elog "You will need to configure offlineimap by creating ~/.offlineimaprc"
	elog "Sample configurations are in /usr/share/doc/${PF}/"
	elog ""
}
