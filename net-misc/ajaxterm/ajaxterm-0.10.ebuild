# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ajaxterm/ajaxterm-0.10.ebuild,v 1.1 2006/12/13 19:56:15 genstef Exp $

MY_P=Ajaxterm-${PV}
DESCRIPTION="Ajaxterm is a web based terminal"
HOMEPAGE="http://antony.lesuisse.org/qweb/trac/wiki/AjaxTerm"
SRC_URI="http://antony.lesuisse.org/qweb/files/${MY_P}.tar.gz"

LICENSE="public-domain LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.0"
S=${WORKDIR}/${MY_P}

src_compile() {
	# baselayout's start-stop-daemon wrapper does not allow shell scripts
	sed -i -e "s: -- :\0/usr/share/ajaxterm/ajaxterm.py :" \
		-e "s:\(DAEMON=%(bin)s/\)ajaxterm:\1python:" configure.initd.gentoo

	./configure --prefix=/usr || die "./configure failed"
}

src_install() {
	dodir /etc/init.d
	sed -i -e "s:\"/usr:\"${D}/usr:" \
		-e "s:\"/etc:\"${D}/etc:" \
		-e "s:/usr/man:/usr/share/man:" Makefile
	emake install || die "emake install failed"
}

pkg_postinst() {
	ewarn "For remote access, it is strongly recommended to use https SSL/TLS"
	ewarn "On the website is a config for apache web server using mod_proxy"
}
