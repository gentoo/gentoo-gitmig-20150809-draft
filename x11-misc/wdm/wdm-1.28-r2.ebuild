# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wdm/wdm-1.28-r2.ebuild,v 1.7 2009/01/09 14:28:12 remi Exp $

inherit pam

DESCRIPTION="WINGs Display Manager"
HOMEPAGE="http://voins.program.ru/wdm/"
SRC_URI="http://voins.program.ru/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc64 ~sparc ~x86"
IUSE="truetype pam selinux"

RDEPEND=">=x11-wm/windowmaker-0.70.0
	truetype? ( x11-libs/libXft )
	x11-libs/libXt
	x11-libs/libXpm
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	sys-devel/gettext"
RDEPEND="${RDEPEND}
	pam? ( >=sys-auth/pambase-20080219.1 )"

src_compile() {
	econf \
		--exec-prefix=/usr \
		--with-wdmdir=/etc/X11/wdm \
		$(use_enable pam)\
		$(use_enable selinux) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}/etc/pam.d/wdm"
	pamd_mimic system-local-login wdm auth account password session
}
