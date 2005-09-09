# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dstat/dstat-0.6.0-r1.ebuild,v 1.1 2005/09/09 11:48:17 swegener Exp $

inherit python

DESCRIPTION="Dstat is a versatile replacement for vmstat, iostat and ifstat"
HOMEPAGE="http://dag.wieers.com/home-made/dstat/"
SRC_URI="http://dag.wieers.com/home-made/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="virtual/python"
DEPEND=""

src_compile() {
	true
}

src_install() {
	dobin dstat || die "dobin failed"

	insinto /usr/share/dstat
	doins plugins/*.py || die "doins failed"

	doman dstat.1 || die "doman failed"
	dodoc \
		AUTHORS ChangeLog README* TODO dstat.conf \
		examples/{mstat,read}.py || die "dodoc failed"
}

pkg_postinst() {
	python_mod_optimize /usr/share/dstat

	einfo
	einfo "See the included dstat.conf in the doc directory for"
	einfo "an example on how to setup a custom /etc/dstat.conf"
	einfo
}

pkg_postrm() {
	python_mod_cleanup /usr/share/dstat
}
