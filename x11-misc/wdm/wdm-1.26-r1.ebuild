# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wdm/wdm-1.26-r1.ebuild,v 1.5 2005/09/17 02:03:50 agriffis Exp $

inherit eutils pam

IUSE="truetype pam png jpeg gif tiff"

DESCRIPTION="WINGs Display Manager"
HOMEPAGE="http://voins.program.ru/wdm/"
SRC_URI="http://voins.program.ru/${PN}/${P}.tar.bz2"

SLOT="0"
KEYWORDS="alpha ~amd64 x86"
LICENSE="GPL-2"

RDEPEND=">=x11-wm/windowmaker-0.65.1
	virtual/x11
	truetype? ( virtual/xft )
	pam? ( sys-libs/pam )"

DEPEND="${RDEPEND}
	sys-devel/gettext"

src_compile() {
	econf \
		--exec-prefix=/usr \
		--with-wdmdir=/etc/X11/wdm \
		$(use_enable pam)\
		$(use_enable png)\
		$(use_enable jpeg)\
		$(use_enable gif)\
		$(use_enable tiff) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	rm -f ${D}/etc/pam.d/wdm
	newpamd "${FILESDIR}/wdm-include" wdm
}
