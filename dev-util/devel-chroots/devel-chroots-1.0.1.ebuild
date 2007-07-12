# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devel-chroots/devel-chroots-1.0.1.ebuild,v 1.9 2007/07/12 01:05:42 mr_bones_ Exp $

DESCRIPTION="Gentoo Developer chroots installation/configuration launcher"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/docs/devel-chroots-intro.xml"

SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

# for testing purposes only
# KEYWORDS="-*"
# expected first scope, will be expanded to amd64 and/or ia64 when test machines available
KEYWORDS="amd64 ~hppa ppc ~sparc x86"

IUSE=""

DEPEND="app-misc/screen net-misc/wget sys-apps/sed"

src_compile() {
	emake || die "emake failed"

	sed -i 	-e "s|DEVEL_CHROOTS_USER_DEFINED_ARCHITECT=\"x86\"|DEVEL_CHROOTS_USER_DEFINED_ARCHITECT=\"${ARCH}\"|g" \
			-e "s|DEVEL_CHROOTS_USER_SELECTED_KEYWORDS=\"~x86 x86\"|DEVEL_CHROOTS_USER_SELECTED_KEYWORDS=\"~${ARCH} ${ARCH}\"|g" \
			"${WORKDIR}/${P}/config/devel-chroots-user.conf"
}

src_install() {
	make DESTDIR="${D}" install || die
}
