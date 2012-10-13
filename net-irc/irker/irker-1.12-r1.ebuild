# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irker/irker-1.12-r1.ebuild,v 1.2 2012/10/13 21:07:45 floppym Exp $

EAPI=4

inherit python

DESCRIPTION="Submission tools for IRC notifications"
HOMEPAGE="http://www.catb.org/esr/irker/"
SRC_URI="http://www.catb.org/esr/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="app-text/xmlto
	dev-python/irc"
RDEPEND="${DEPEND}
	=dev-lang/python-2*"

src_install() {
	# the irkerhook.py is not installed with the default makefile
	emake DESTDIR="${D}" install
	cp ${S}/irkerhook.py ${D}/usr/bin/ || die "Failed to install the irkerhook"
	mkdir -p ${D}/etc/init.d/ ${D}/etc/conf.d/
	cp ${FILESDIR}/irker.init ${D}/etc/init.d/irkerd || die "Failed to install init script"
	chmod 755 ${D}/etc/init.d/irkerd # need to be executable
	cp ${FILESDIR}/irker.conf.d ${D}/etc/conf.d/irkerd || die "Failed to install conf"
	python_convert_shebangs -r 2 "${D}"
}
