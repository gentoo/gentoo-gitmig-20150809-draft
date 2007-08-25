# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webapp-config/webapp-config-1.50.16-r1.ebuild,v 1.10 2007/08/25 11:44:52 vapier Exp $

inherit eutils distutils

DESCRIPTION="Gentoo's installer for web-based applications"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://build.pardus.de/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-apache-move.patch
}

src_install() {

	# According to this discussion:
	# http://mail.python.org/pipermail/distutils-sig/2004-February/003713.html
	# distutils does not provide for specifying two different script install
	# locations. Since we only install one script here the following should
	# be ok
	distutils_src_install --install-scripts="/usr/sbin"

	dodir /etc/vhosts
	cp config/webapp-config ${D}/etc/vhosts/
	keepdir /usr/share/webapps
	keepdir /var/db/webapps
	dodoc examples/phpmyadmin-2.5.4-r1.ebuild AUTHORS.txt TODO.txt CHANGES.txt examples/postinstall-en.txt
	doman doc/webapp-config.5 doc/webapp-config.8 doc/webapp.eclass.5
	dohtml doc/webapp-config.5.html doc/webapp-config.8.html doc/webapp.eclass.5.html
}

src_test() {
	cd ${S}
	distutils_python_version
	if [[ $PYVER_MAJOR -gt 1 ]] && [[ $PYVER_MINOR -gt 3 ]] ; then
		elog "Running webapp-config doctests..."
		if ! PYTHONPATH="." ${python} WebappConfig/tests/dtest.py; then
			eerror "DocTests failed - please submit a bug report"
			die "DocTesting failed!"
		fi
	else
		elog "Python version below 2.4! Disabling tests."
	fi
}

pkg_postinst() {
	echo
	elog "Now that you have upgraded webapp-config, you **must** update your"
	elog "config files in /etc/vhosts/webapp-config before you emerge any"
	elog "packages that use webapp-config."
	echo
	epause 5
}
