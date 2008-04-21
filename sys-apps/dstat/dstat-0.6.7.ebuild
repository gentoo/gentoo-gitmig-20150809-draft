# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dstat/dstat-0.6.7.ebuild,v 1.3 2008/04/21 16:52:34 armin76 Exp $

inherit python

DESCRIPTION="Dstat is a versatile replacement for vmstat, iostat and ifstat"
HOMEPAGE="http://dag.wieers.com/home-made/dstat/"
SRC_URI="http://dag.wieers.com/home-made/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="virtual/python"
DEPEND=""

src_compile() {
	true
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"

	dodoc \
		AUTHORS ChangeLog README TODO dstat.conf \
		examples/{mstat,read}.py docs/*.txt \
		|| die "dodoc failed"
	dohtml docs/*.html || die "dohtml failed"
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
