# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_conference/asterisk-app_conference-0.0.1_pre20050506.ebuild,v 1.7 2011/05/01 00:39:08 halcy0n Exp $

inherit eutils

MY_PN="app_conference"
MY_P="${MY_PN}-${PV/0.0.1_pre/}"

DESCRIPTION="Asterisk application plugin for conferences"
HOMEPAGE="http://iaxclient.sourceforge.net/"
SRC_URI="mirror://gentoo/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"

IUSE=""

# depends on glibc's iconv support
DEPEND=">=net-misc/asterisk-1.0.5-r1
	!>=net-misc/asterisk-1.2.0"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}

	cd "${S}"
	# use asterisk-config...
	epatch "${FILESDIR}"/${MY_P}-astcfg.diff

	# compile fixes for asterisk-stable
	epatch "${FILESDIR}"/${MY_P}-compile.patch
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc README
}
