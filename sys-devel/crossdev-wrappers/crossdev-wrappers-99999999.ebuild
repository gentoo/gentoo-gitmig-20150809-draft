# Copyright 2008-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/crossdev-wrappers/crossdev-wrappers-99999999.ebuild,v 1.1 2009/03/19 14:57:41 armin76 Exp $

inherit toolchain-funcs eutils cvs

DESCRIPTION="emerge wrappers for crossdev"
HOMEPAGE="http://embedded.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

ECVS_SERVER="anoncvs.gentoo.org:/var/cvsroot"
ECVS_MODULE="gentoo-projects/crossdev-wrappers"
ECVS_AUTH="pserver"
ECVS_USER="anonymous"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/gentoo-projects/${PN}"

src_compile() {
	emake PREFIX=/usr || die
}

src_install() {
	find -name CVS -print0 | xargs -0 rm -rf
	emake PREFIX=/usr DESTDIR="${D}" install || die
}

pkg_postinst() {
	einfo "Running emerge-wrapper --init"
	emerge-wrapper --init
}
