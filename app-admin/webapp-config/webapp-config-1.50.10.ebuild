# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webapp-config/webapp-config-1.50.10.ebuild,v 1.4 2006/02/27 01:53:33 weeve Exp $

inherit eutils distutils

DESCRIPTION="Gentoo's installer for web-based applications"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentoo.org/~wrobel/webapp-config/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ppc ~ppc64 sparc x86"
IUSE=""
S=${WORKDIR}/${PF}

DEPEND=""

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
	dodoc examples/phpmyadmin-2.5.4-r1.ebuild AUTHORS.txt TODO.txt CHANGES.txt examples/postinstall-en.txt
	doman doc/webapp-config.5 doc/webapp-config.8 doc/webapp.eclass.5
	dohtml doc/webapp-config.5.html doc/webapp-config.8.html doc/webapp.eclass.5.html
}

src_test() {
	cd ${S}
	einfo "Running webapp-config doctests..."
	if ! PYTHONPATH="." ${python} WebappConfig/tests/dtest.py; then
		eerror "DocTests failed - please submit a bug report"
		die "DocTesting failed!"
	fi
}

pkg_postinst() {
	echo
	einfo "Now that you have upgraded webapp-config, you **must** update your"
	einfo "config files in /etc/vhosts/webapp-config before you emerge any"
	einfo "packages that use webapp-config."
	echo
	epause 5
}
