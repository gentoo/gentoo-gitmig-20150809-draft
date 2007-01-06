# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_nv_faxdetect/asterisk-app_nv_faxdetect-1.0.6.ebuild,v 1.7 2007/01/06 16:30:24 drizzt Exp $

inherit eutils

MY_PN="app_nv_faxdetect"

DESCRIPTION="Asterisk plugins to detect faxes, dtfm and voice (faxdetect and backgrounddetect)"
HOMEPAGE="http://www.newmantelecom.com/asterisk/faxdetect/"
SRC_URI="mirror://gentoo/${MY_PN}-${PV}.tar.bz2"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

DEPEND=">=net-misc/asterisk-1.0.5-r1"

S="${WORKDIR}"/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}

	cd "${S}"
	# use asterisk-config...
	epatch "${FILESDIR}"/app_nv_faxdetect-${PV}-astcfg.diff

	if has_version "<net-misc/asterisk-1.1.0"; then
		einfo "Building for Asterisk-1.0.x"
		# change callerid to asterisk stable
		epatch "${FILESDIR}"/app_nv_faxdetect-${PV}-ast10.diff
	else
		einfo "Building for Asterisk-1.2.x"
		epatch "${FILESDIR}"/app_nv_faxdetect-${PV}-ast12.diff
	fi
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
}

pkg_postinst() {
	elog "See"
	echo
	elog "  http://www.voip-info.org/wiki-NVFaxDetect"
	elog "  http://www.voip-info.org/wiki-NVBackgroundDetect"
	echo
	elog "for more information"
}
