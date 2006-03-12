# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/multiimonc/multiimonc-0.3.6.ebuild,v 1.7 2006/03/12 18:37:26 mrness Exp $

inherit eutils

DESCRIPTION="A wxWidgets-based client for fli4l"
SRC_URI="http://hansmi.nanofortnight.org/multiimonc/MultiImonC-${PV}.tar.bz2"
HOMEPAGE="http://www.hansmi.ch/software/multiimonc"

S="${WORKDIR}/MultiImonC-${PV}"

KEYWORDS="amd64 hppa ppc sparc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="=x11-libs/wxGTK-2.4*"

src_unpack() {
	unpack ${A}
	cd "${S}/src"
	epatch "${FILESDIR}/${PV}-TextScrollWindow.diff" || die "epatch failed"
	cd "${S}"
}

src_compile() {
	econf || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install problem"
}
