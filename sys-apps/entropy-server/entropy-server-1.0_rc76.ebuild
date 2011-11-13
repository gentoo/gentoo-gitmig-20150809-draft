# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/entropy-server/entropy-server-1.0_rc76.ebuild,v 1.1 2011/11/13 09:28:17 lxnay Exp $

EAPI="3"
PYTHON_DEPEND="2"
inherit eutils python bash-completion-r1

DESCRIPTION="Entropy Package Manager server-side tools"
HOMEPAGE="http://www.sabayon.org"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_URI="mirror://sabayon/sys-apps/entropy-${PV}.tar.bz2"

S="${WORKDIR}/entropy-${PV}/server"

RDEPEND="~sys-apps/entropy-${PV}"
DEPEND="app-text/asciidoc"

src_compile() {
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	newbashcomp "${S}/eit-completion.bash" eit
}

pkg_postinst() {
	python_mod_optimize "/usr/lib/entropy/server"
}

pkg_postrm() {
	python_mod_cleanup "/usr/lib/entropy/server"
}
