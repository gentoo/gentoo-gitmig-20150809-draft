# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-sync-engine/synce-sync-engine-0.15.1-r1.ebuild,v 1.1 2011/02/25 17:49:40 ssuominen Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A synchronization engine for SynCE"
HOMEPAGE="http://www.synce.org/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/librapi2[python]
	dev-libs/libxml2[python]
	dev-libs/libxslt[python]
	dev-python/dbus-python
	dev-python/pygobject"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="SyncEngine"

src_prepare() {
	sed -i -e 's:share/doc/sync-engine:foobar:' setup.py || die

	distutils_src_prepare
}

src_install() {
	insinto /usr/share/dbus-1/services
	doins config/org.synce.SyncEngine.service || die

	insinto /etc
	doins config/syncengine.conf.xml || die

	distutils_src_install

	# opensync plug-in begin
	find "${D}" -type d -name plugins -exec rm -rf {} +

	docinto synce-opensync-plugin
	dodoc plugins/synce-opensync-plugin-* || die
	# end

	rm -rf "${D}"/usr/foobar
}

pkg_postinst() {
	distutils_pkg_postinst

	einfo "See /usr/share/doc/${PF}/synce-opensync-plugin for opensync plug-in."
}
