# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/idutils/idutils-4.2.ebuild,v 1.2 2007/11/27 07:07:16 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Fast, high-capacity, identifier database tool"
HOMEPAGE="http://www.gnu.org/software/idutils/"
DEB_PN="id-utils" # old upstream name for it
DEB_P="${DEB_PN}_${PV}"
DEB_PR="1"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
		mirror://debian/pool/main/${PN:0:1}/${DEB_PN}/${DEB_P}-${DEB_PR}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="emacs nls"

RDEPEND="emacs? ( virtual/emacs )
		 nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
		nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch "${DISTDIR}"/${DEB_P}-${DEB_PR}.diff.gz
	epatch "${S}"/debian/patches/*.dpatch
}

src_compile() {
	econf $(use_enable nls) || die
	if use emacs; then
		emake || die
	else
		emake EMACS="no" || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc NEWS README* ChangeLog AUTHORS THANKS TODO
}
