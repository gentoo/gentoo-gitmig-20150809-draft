# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/wm-icons/wm-icons-0.4.0.ebuild,v 1.1 2007/03/08 19:05:36 anant Exp $

DESCRIPTION="A Large Assortment of Beutiful Themed Icons, Created with FVWM in mind"

HOMEPAGE="http://wm-icons.sourceforge.net/"
SRC_URI="mirror://sourceforge/wm-icons/wm-icons-${PV}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"

IUSE=""
RDEPEND="sys-apps/gawk dev-lang/perl"
DEPEND="${RDEPEND} sys-devel/autoconf sys-devel/automake sys-apps/sed"

src_compile() {
	econf --enable-all-sets --enable-icondir=/usr/share/icons/wm-icons || die "econf failed"
	emake
}

src_install() {
	make icondir=${D}/usr/share/icons/wm-icons DESTDIR=${D} install

	einfo "Setting default aliases..."
	${D}/usr/bin/wm-icons-config --force --user-dir="${D}/usr/share/icons/wm-icons" --defaults

	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}

pkg_postinst() {
	einfo "Users can use the wm-icons-config utility to create aliases in their"
	einfo "home directory, FVWM users can then set this in their ImagePath"
	einfo
	einfo "Sample configurations for fvwm1, fvwm2, fvwm95 and scwm are available in"
	einfo "/usr/share/wm-icons"
	einfo
}
