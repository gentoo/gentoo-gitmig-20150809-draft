# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skim/skim-1.0.2.ebuild,v 1.1 2004/10/21 10:25:01 usata Exp $

DESCRIPTION="Smart Common Input Method (SCIM) optimized for KDE"
HOMEPAGE="http://scim.freedesktop.org/Software/ScimKDE"
SRC_URI="mirror://sourceforge/scim/${P}.tar.bz2
	http://freedesktop.org/~cougar/skim/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/x11
	|| ( >=app-i18n/scim-0.99.4 >=app-i18n/scim-cvs-0.99.4 )
	>=x11-libs/qt-3.2.0
	>=kde-base/kdelibs-3.2.0"

src_compile() {
	addpredict /usr/qt/3/etc/settings
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog NEWS README TODO
	mv ${D}/usr/share/doc/HTML ${D}/usr/share/doc/${PF}/html
}

pkg_postinst() {
	einfo
	einfo "If you want to use Chinese interface, edit your startup script"
	einfo "such as .xinitrc to incorporate"
	einfo
	einfo '	export XMODIFIERS=@im=SCIM'
	einfo '	export LANG="zh_CN.GBK"'
	einfo '	startkde'
	einfo
	einfo "or if you prefer English interface,"
	einfo
	einfo '	export XMODIFIERS=@im=SCIM'
	einfo '	export LC_CTYPE="zh_CN.GBK"'
	einfo '	startkde'
	einfo
	einfo "and start skim and SCIM by"
	einfo
	einfo "	% skim -d"
	einfo
}
