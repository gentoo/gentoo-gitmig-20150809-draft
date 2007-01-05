# Copyright 2000-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skim/skim-1.4.5.ebuild,v 1.11 2007/01/05 16:33:30 flameeyes Exp $

inherit kde-functions multilib toolchain-funcs

DESCRIPTION="Smart Common Input Method (SCIM) optimized for KDE"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.bz2
	http://freedesktop.org/~cougar/skim/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( >=app-i18n/scim-1.4.4 >=app-i18n/scim-cvs-1.4.4 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

need-kde 3.2

src_compile() {
	local sconsopts=$(echo "${MAKEOPTS}" | sed -e "s/.*\(-j[0-9]\+\).*/\1/")
	[[ ${MAKEOPTS/-s/} != ${MAKEOPTS} ]] && sconsopts="${sconsopts} -s"

	tc-export CC CXX

	CFLAGS="${CXXFLAGS}" ./configure prefix=/usr libdir=/usr/$(get_libdir) || die
	CFLAGS="${CXXFLAGS}" ./scons ${sconsopts} || die
}

src_install() {
	DESTDIR=${D} ./scons prefix=/usr install || die
	mv ${D}/usr/share/doc/HTML ${D}/usr/share/doc/${PF}/html

	# Install the .desktop file in FDO's suggested directory
	dodir /usr/share/applications/kde
	mv ${D}/usr/share/applnk/Utilities/skim.desktop \
		${D}/usr/share/applications/kde

	dodoc ChangeLog AUTHORS NEWS README TODO
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
