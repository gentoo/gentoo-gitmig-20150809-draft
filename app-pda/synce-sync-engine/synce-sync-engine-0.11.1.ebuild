# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-sync-engine/synce-sync-engine-0.11.1.ebuild,v 1.1 2008/11/13 16:31:01 mescalinum Exp $

inherit eutils distutils

DESCRIPTION="SynCE - Synchronization engine"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="dev-python/pygobject
		dev-python/dbus-python
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

src_compile() {
	distutils_src_compile
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
	ewarn "IMPORTANT - If you are upgrading from a version earlier than 19-12-2007"
	ewarn "(earlier than 0.11), please delete the contents of your ~/.synce directory"
	ewarn "including the partnerships subdirectory, but KEEP config.xml. Then recreate"
	ewarn "your partnerships. Please see the CHANGELOG for more info"

	einfo "Plase copy:"
	einfo "/usr/share/${PN}/config.xml"
	einfo "to"
	einfo "~/.synce/ directory"
	einfo "Change it to fit your needs"
}
