# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_nv_faxdetect/asterisk-app_nv_faxdetect-1.0.6.ebuild,v 1.4 2005/08/16 16:39:19 stkn Exp $

inherit eutils

MY_PN="app_nv_faxdetect"

DESCRIPTION="Asterisk plugins to detect faxes, dtfm and voice (faxdetect and backgrounddetect)"
HOMEPAGE="http://www.newmantelecom.com/asterisk/faxdetect/"
SRC_URI="mirror://gentoo/${MY_PN}-${PV}.tar.bz2"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="sys-libs/glibc
	>=net-misc/asterisk-1.0.5-r1"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}

	cd ${S}
	# use asterisk-config...
	epatch ${FILESDIR}/app_nv_faxdetect-${PV}-astcfg.diff

	if has_version "<net-misc/asterisk-1.1.0"; then
		einfo "Building for Asterisk-1.0.x"
		# change callerid to asterisk stable
		epatch ${FILESDIR}/app_nv_faxdetect-${PV}-aststable.diff
	else
		einfo "Building for Asterisk-1.2.x"
	fi
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	einfo "See"
	einfo ""
	einfo "  http://www.voip-info.org/wiki-NVFaxDetect"
	einfo "  http://www.voip-info.org/wiki-NVBackgroundDetect"
	einfo ""
	einfo "for more information"
}
