# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/emirror/emirror-2.2.0.0.4.ebuild,v 1.1 2010/01/19 15:46:54 cla Exp $

inherit versionator

MY_PV=$(replace_version_separator 3 '-')

DESCRIPTION="ECLiPt FTP mirroring tool"
HOMEPAGE="http://sourceforge.net/projects/emirror/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S="${WORKDIR}"/${PN}-${MY_PV}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake \
		prefix="${D}"/usr \
		mandir="${D}"/usr/share/man/man1 \
		sysconfdir="${D}"/etc \
		htmldir="${D}"/var/www/mirrors \
	install || die "emake install failed"
	dodoc doc/*
}
