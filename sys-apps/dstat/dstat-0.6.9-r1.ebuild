# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dstat/dstat-0.6.9-r1.ebuild,v 1.2 2011/03/06 10:42:45 jlec Exp $

EAPI=2

PYTHON_DEPEND="2"

inherit python eutils

DESCRIPTION="Dstat is a versatile replacement for vmstat, iostat and ifstat"
HOMEPAGE="http://dag.wieers.com/home-made/dstat/"
SRC_URI="http://dag.wieers.com/home-made/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ~ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND=""
DEPEND=""

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-CVE-2009-3894.patch # 293497
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"

	dodoc \
		AUTHORS ChangeLog README TODO \
		examples/{mstat,read}.py docs/*.txt \
		|| die "dodoc failed"
	dohtml docs/*.html || die "dohtml failed"
}

pkg_postinst() {
	python_mod_optimize /usr/share/dstat
}

pkg_postrm() {
	python_mod_cleanup /usr/share/dstat
}
