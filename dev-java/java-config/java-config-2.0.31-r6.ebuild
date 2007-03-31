# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config/java-config-2.0.31-r6.ebuild,v 1.1 2007/03/31 19:36:59 betelgeuse Exp $

inherit base distutils eutils

DESCRIPTION="Java environment configuration tool"
HOMEPAGE="http://www.gentoo.org/proj/en/java/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~ia64"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}
	dev-java/java-config-wrapper"

PATCHES="${FILESDIR}/jdk-defaults-ia64.conf.patch"

src_install() {
	distutils_src_install

	insinto /usr/share/java-config-2/config/
	for i in alpha amd64 hppa ia64 ppc ppc64 sparc x86 x86-fbsd; do
		if use ${i}; then
			newins config/jdk-defaults-${i}.conf jdk-defaults.conf || die "arch	config not found"
		fi
	done

	for tool in $(< config/symlink-tools); do
		dosym /usr/bin/run-java-tool /usr/bin/${tool}
	done

	# Install profile.d for setting JAVA_HOME
	dodir /etc/profile.d
	exeinto /etc/profile.d
	newexe ${FILESDIR}/${PN}-${SLOT}.profiled.sh-r1 ${PN}-${SLOT}.sh || die "newexe failed"
	newexe ${FILESDIR}/${PN}-${SLOT}.profiled.csh ${PN}-${SLOT}.csh || die "newexe failed"

	insinto /etc/revdep-rebuild/
	doins "${FILESDIR}/60-java" || die
}

pkg_postrm() {
	python_mod_cleanup /usr/share/java-config-2/pym/java_config
}

pkg_postinst() {
	python_mod_optimize /usr/share/java-config-2/pym/java_config

	elog "The way Java is handled on Gentoo has been recently updated."
	elog "If you have not done so already, you should follow the"
	elog "instructions available at:"
	elog "\thttp://www.gentoo.org/proj/en/java/java-upgrade.xml"
	elog
	elog "While we are moving towards the new Java system, we only allow"
	elog "1.3 or 1.4 JDKs to be used with java-config-1 to ensure"
	elog "backwards compatibility with the old system."
	elog "For more details about this, please see:"
	elog "\thttp://www.gentoo.org/proj/en/java/why-we-need-java-14.xml"
}
