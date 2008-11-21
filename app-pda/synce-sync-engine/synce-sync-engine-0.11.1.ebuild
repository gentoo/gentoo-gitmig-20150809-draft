# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-sync-engine/synce-sync-engine-0.11.1.ebuild,v 1.2 2008/11/21 00:11:37 mescalinum Exp $

inherit eutils distutils

DESCRIPTION="SynCE - Synchronization engine"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="dev-python/pygobject
		>=dev-python/dbus-python-0.83.0
		>=app-pda/libopensync-plugin-python-0.21
		dev-libs/libxml2
		dev-libs/libxslt
		dev-python/pyxml
		dev-python/setuptools
		~app-pda/synce-odccm-0.11.1
		~app-pda/synce-librra-0.11.1
		~app-pda/synce-librtfcomp-1.1"

SRC_URI="mirror://sourceforge/synce/sync-engine-${PV}.tar.gz"
S=${WORKDIR}/sync-engine-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-typo.patch"
}

src_install() {
	DOCS="CHANGELOG COPYING"
	distutils_src_install

	insinto /usr/share/${PN}/
	doins config/config.xml

	insinto /usr/lib/opensync/python-plugins

	# TODO - move this to separate ebuilds.
	if has_version '>=app-pda/libopensync-0.30'; then
		newins plugins/synce-opensync-plugin-3x.py synce-opensync-plugin.py
	else
		newins plugins/synce-opensync-plugin-2x.py synce-opensync-plugin.py
	fi
}

pkg_postinst() {
	elog "IMPORTANT - If you are upgrading from a version earlier than 19-12-2007"
	elog "(earlier than 0.11), please delete the contents of your ~/.synce directory"
	elog "including the partnerships subdirectory, but KEEP config.xml. Then recreate"
	elog "your partnerships. Please see the CHANGELOG for more info"

	elog "Plase copy:"
	elog "/usr/share/${PN}/config.xml"
	elog "to"
	elog "~/.synce/ directory"
	elog "Change it to fit your needs"
}
