# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-sync-engine/synce-sync-engine-0.15.1-r1.ebuild,v 1.4 2011/03/28 01:47:32 ssuominen Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils multilib

DESCRIPTION="A synchronization engine for SynCE"
HOMEPAGE="http://www.synce.org/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="opensync"

RDEPEND="dev-libs/librapi2[python]
	dev-libs/librra[python]
	dev-libs/librtfcomp[python]
	dev-libs/libxml2[python]
	dev-libs/libxslt[python]
	dev-python/dbus-python
	dev-python/pygobject
	opensync? ( >=app-pda/libopensync-0.22 )"
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

	### opensync plug-in BEGIN
	find "${D}" -type d -name plugins -exec rm -rf {} +

	if use opensync; then
		insinto /usr/$(get_libdir)/opensync/python-plugin
		local plug=plugins/synce-opensync-plugin-

		if has_version ">=app-pda/libopensync-0.30"; then
			newins ${plug}3x.py synce-plugin.py || die
		else
			newins ${plug}2x.py synce-plugin.py || die
		fi

		dodoc ${plug}3x.README || die
	fi
	### opensync plug-in END

	rm -rf "${D}"/usr/foobar
}
