# Copyright 2000-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skim/skim-1.4.4.ebuild,v 1.1 2006/02/16 19:02:33 liquidx Exp $

inherit kde multilib

DESCRIPTION="Smart Common Input Method (SCIM) optimized for KDE"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.bz2
	http://freedesktop.org/~cougar/skim/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="|| ( >=app-i18n/scim-1.3.3 >=app-i18n/scim-cvs-1.3.3 )"

need-kde 3.2

src_compile() {
	CFLAGS="${CXXFLAGS}" ./configure prefix=/usr libdir=/usr/$(get_libdir) || die
	CFLAGS="${CXXFLAGS}" ./scons || die
}

src_install() {
	DESTDIR=${D} ./scons prefix=/usr install || die
	mv ${D}/usr/share/doc/HTML ${D}/usr/share/doc/${PF}/html
}

pkg_postinst() {
	einfo
	einfo "If you want to use Chinese interface, edit your startup script"
	einfo "such as .xinitrc to incorporate"
	einfo
	einfo '	export XMODIFIERS=@im=SCIM'
	einfo ' export QT_IM_MODULE=scim'
	einfo ' export GTK_IM_MODULE=scim'
	einfo '	export LANG="zh_CN.GBK"'
	einfo '	startkde'
	einfo
	einfo "or if you prefer English interface,"
	einfo
	einfo '	export XMODIFIERS=@im=SCIM'
	einfo ' export QT_IM_MODULE=scim'
	einfo ' export GTK_IM_MODULE=scim'
	einfo '	export LC_CTYPE="zh_CN.GBK"'
	einfo '	startkde'
	einfo
	einfo "and start skim and SCIM by"
	einfo
	einfo "	% skim -d"
	einfo
}
