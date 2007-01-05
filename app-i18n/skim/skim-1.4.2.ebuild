# Copyright 2000-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skim/skim-1.4.2.ebuild,v 1.4 2007/01/05 16:33:30 flameeyes Exp $

inherit kde multilib

DESCRIPTION="Smart Common Input Method (SCIM) optimized for KDE"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.bz2
	http://freedesktop.org/~cougar/skim/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="|| ( >=app-i18n/scim-1.3.3 >=app-i18n/scim-cvs-1.3.3 )"

need-kde 3.2

src_compile() {
	#sed -i -e "/=.*DESTDIR/s@\(\['DESTDIR'\]\)@\1 + '/usr'@" bksys/generic.py || die
	#sed -i -e "/basedir =.*DESTDIR/s@\(\['DESTDIR'\]\)@\1 + '/usr'@g" bksys/generic.py || die
	#sed -i -e "s@\(basedir+subdir\)@\1+'/usr'@g" bksys/generic.py || die
	./configure prefix=/usr libdir=/usr/$(get_libdir) || die
	./scons || die
}

src_install() {
	DESTDIR=${D} ./scons prefix=/usr install || die

	mv ${D}/usr/share/doc/HTML ${D}/usr/share/doc/${PF}/html
}

pkg_postinst() {
	elog
	elog "If you want to use Chinese interface, edit your startup script"
	elog "such as .xinitrc to incorporate"
	elog
	elog '	export XMODIFIERS=@im=SCIM'
	elog ' export QT_IM_MODULE=scim'
	elog ' export GTK_IM_MODULE=scim'
	elog '	export LANG="zh_CN.GBK"'
	elog '	startkde'
	elog
	elog "or if you prefer English interface,"
	elog
	elog '	export XMODIFIERS=@im=SCIM'
	elog ' export QT_IM_MODULE=scim'
	elog ' export GTK_IM_MODULE=scim'
	elog '	export LC_CTYPE="zh_CN.GBK"'
	elog '	startkde'
	elog
	elog "and start skim and SCIM by"
	elog
	elog "	% skim -d"
	elog
}
