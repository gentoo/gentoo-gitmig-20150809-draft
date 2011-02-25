# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-sync-engine/synce-sync-engine-0.15.1.ebuild,v 1.4 2011/02/25 16:44:33 ssuominen Exp $

# TODO:
# Figure out synce-opensync-plugin-2x.py and synce-opensync-plugin-3x.py install path when libopensync is unmasked.

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

PYTHON_MODNAME="plugins SyncEngine"

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

	rm -rf "${D}"/usr/foobar
}
