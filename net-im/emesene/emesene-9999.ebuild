# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/emesene/emesene-9999.ebuild,v 1.6 2012/11/02 22:31:50 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
EGIT_REPO_URI="git://github.com/${PN}/${PN}.git
	http://github.com/${PN}/${PN}.git"

inherit distutils eutils git-2

DESCRIPTION="Platform independent MSN Messenger client written in Python+GTK"
HOMEPAGE="http://www.emesene.org"

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 )"
SLOT="2"
KEYWORDS=""
IUSE="jabber"

RDEPEND="dev-python/pygtk:2
	dev-python/papyon
	dev-python/notify-python
	dev-python/pywebkitgtk
	jabber? ( dev-python/xmpppy )"

src_prepare() {
	# do not import dummy session
	sed -i -e  "/import e3dummy/d" ${PN}/${PN}.py || die
	distutils_src_prepare
}

pkg_postinst() {
	elog
	elog "${PN} is on early stages of development."
	elog "Please do not file bugs on Gentoo bugzilla"
	elog "unless you have problems with this ebuild."
	elog "Use the upstram bug tracker to report bugs:"
	elog
	elog "https://github.com/emesene/emesene/issues"
}
