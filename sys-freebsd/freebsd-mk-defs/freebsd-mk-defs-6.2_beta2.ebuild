# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-mk-defs/freebsd-mk-defs-6.2_beta2.ebuild,v 1.2 2006/10/17 09:50:57 uberlord Exp $

inherit bsdmk freebsd

DESCRIPTION="Makefiles definitions used for building and installing libraries and system files"
SLOT="0"
KEYWORDS="~amd64 ~sparc-fbsd ~x86-fbsd"

IUSE=""

SRC_URI="mirror://gentoo/${SHARE}.tar.bz2"

RDEPEND=""
DEPEND=""

RESTRICT="nostrip"

S="${WORKDIR}/share/mk"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/share
	epatch "${FILESDIR}/${PN}-6.1-gentoo.patch"

	[[ ${CHOST} != *-*bsd* || ${CHOST} == *-gnu ]] && \
		epatch "${FILESDIR}/${PN}-6.0-gnu.patch"
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	if [[ ${CHOST} != *-freebsd* ]]; then
		insinto /usr/share/mk/freebsd
	else
		insinto /usr/share/mk
	fi
	doins *.mk
}
