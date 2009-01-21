# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-sync-engine/synce-sync-engine-0.13.ebuild,v 1.1 2009/01/21 00:41:24 mescalinum Exp $

inherit eutils distutils

DESCRIPTION="SynCE - Synchronization engine"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="dev-python/pygobject
	>=dev-python/dbus-python-0.83.0
	>=app-pda/libopensync-plugin-python-0.22
	dev-libs/libxml2
	dev-libs/libxslt
	dev-python/pyxml
	~app-pda/synce-librra-0.12
	~app-pda/synce-librtfcomp-1.1"
DEPEND="${RDEPEND}
	dev-python/setuptools"

SRC_URI="mirror://sourceforge/synce/sync-engine-${PV}.tar.gz"
S=${WORKDIR}/sync-engine-${PV}

src_install() {
	DOCS="CHANGELOG COPYING"

	insinto /usr/share/${PN}/
	doins config/syncengine.conf.xml

	insinto /usr/share/dbus-1/services/
	doins config/org.synce.SyncEngine.service

	distutils_src_install

	# TODO - move this to separate ebuilds.
	if has_version '>=app-pda/libopensync-0.30'; then
		insinto /usr/lib/opensync-1.0/python-plugins
		newins plugins/synce-opensync-plugin-3x.py synce-opensync-plugin.py
	else
		insinto /usr/lib/opensync/python-plugins
		newins plugins/synce-opensync-plugin-2x.py synce-opensync-plugin.py
	fi
}

pkg_postinst() {
	elog ""
	elog "IMPORTANT - If you are upgrading from a version earlier than 19-12-2007"
	elog "(earlier than 0.11), please delete the contents of your ~/.synce directory"
	elog "including the partnerships subdirectory, but KEEP config.xml. Then recreate"
	elog "your partnerships. Please see the CHANGELOG for more info."
	elog ""
	elog "config.xml has been renamed to syncengine.conf.xml"
	elog ""

	elog "A default configuration file has been installed into"
	elog "/usr/share/${PN}/syncengine.conf.xml  The default search path for this file"
	einfo "is /etc/ then ~/.synce/  You may customise it by copying it to either of"
	einfo "those locations.  Note you will have to manually migrate your old config.xml"
}
