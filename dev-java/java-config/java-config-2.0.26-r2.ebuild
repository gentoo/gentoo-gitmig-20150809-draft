# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config/java-config-2.0.26-r2.ebuild,v 1.1 2006/07/03 17:18:14 nichoj Exp $

inherit base distutils eutils

DESCRIPTION="Java environment configuration tool"
HOMEPAGE="http://www.gentoo.org/proj/en/java/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/python"
RDEPEND="virtual/python
	dev-java/java-config-wrapper"

PATCHES="${FILESDIR}/${P}-nsplugin.patch ${FILESDIR}/${P}-set_number.patch"

src_install() {
	distutils_src_install

	insinto /usr/share/java-config-2/config/
	for i in alpha amd64 hppa ia64 ppc ppc64 sparc x86; do
		if use ${i}; then
			newins config/jdk-defaults-${i}.conf jdk-defaults.conf || die "arch	config not found"
		fi
	done

	for tool in $(< config/symlink-tools); do
		dosym /usr/bin/run-java-tool /usr/bin/${tool}
	done
}

pkg_postinst() {
	python_mod_optimize /usr/share/java-config-2/pym/java_config
}

pkg_postrm() {
	python_mod_cleanup /usr/share/java-config-2/pym/java_config
}

pkg_postinst() {
	einfo "The way Java is handled on Gentoo has been recently updated."
	einfo "If you have not done so already, you should follow the"
	einfo "instructions available at:"
	einfo "http://www.gentoo.org/proj/en/java/java-upgrade.xml"
}
