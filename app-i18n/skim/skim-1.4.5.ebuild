# Copyright 2000-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skim/skim-1.4.5.ebuild,v 1.8 2006/08/20 04:23:37 weeve Exp $

inherit kde-functions multilib toolchain-funcs

DESCRIPTION="Smart Common Input Method (SCIM) optimized for KDE"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.bz2
	http://freedesktop.org/~cougar/skim/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 ~sparc x86"
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
