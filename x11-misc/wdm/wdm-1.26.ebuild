# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wdm/wdm-1.26.ebuild,v 1.1 2003/12/23 10:07:31 pyrania Exp $

IUSE="truetype pam png jpeg gif tiff"

DESCRIPTION="WINGs Display Manager"
HOMEPAGE="http://voins.program.ru/wdm/"
SRC_URI="http://voins.program.ru/${PN}/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

DEPEND="${RDEPEND}
	virtual/x11
	sys-devel/gettext
	truetype? ( virtual/xft )"
RDEPEND=">=x11-wm/windowmaker-0.65.1"

src_compile() {
	local myconf=""
	use pam && myconf="${myconf} --enable-pam"
	use png || myconf="${myconf} --disable-png"
	use jpeg || myconf="${myconf} --disable-jpeg"
	use gif || myconf="${myconf} --disable-gif"
	use tiff || myconf="${myconf} --disable-tiff"

	econf \
		--exec-prefix=/usr \
		--with-wdmdir=/etc/X11/wdm \
		${myconf} || die
	emake || die
}

src_install() {
	rm ${D}/etc/pam.d/wdm
	insinto /etc/pam.d
	doins ${FILESDIR}/wdm

	make DESTDIR=${D} install || die
}
