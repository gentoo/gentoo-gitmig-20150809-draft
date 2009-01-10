# Copyright 2000-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skim/skim-1.4.5-r2.ebuild,v 1.4 2009/01/10 16:39:25 klausman Exp $

inherit kde-functions multilib toolchain-funcs eutils

DESCRIPTION="Smart Common Input Method (SCIM) optimized for KDE"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.bz2
	http://freedesktop.org/~cougar/skim/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=app-i18n/scim-1.4.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

need-kde 3.2

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-asneeded.patch"
	# bug #211493
	epatch "${FILESDIR}/${P}-kde3.patch"
	sed -i -e "s:/opt/kde3:${KDEDIR}:g" doc/de/index.docbook || die
	# bug #246223
	ln -s libscim-kdeutils.so.0.1.0 utils/libscim-kdeutils.so || die
}

src_compile() {
	local sconsopts=$(echo "${MAKEOPTS}" | sed -e "s/.*\(-j[0-9]\+\).*/\1/")
	[ "${MAKEOPTS/-s/}" != "${MAKEOPTS}" ] && sconsopts="${sconsopts} -s"

	./configure prefix=/usr libdir=/usr/$(get_libdir) || die
	sed -i -e "/^compilers/s:\[:\['$(tc-getCXX)',:" scons-local-0.96.1/SCons/Tool/g++.py || die
	./scons ${sconsopts} || die
}

src_install() {
	DESTDIR="${D}" ./scons prefix=/usr install || die

	# Install the .desktop file in FDO's suggested directory
	dodir /usr/share/applications/kde
	mv "${D}/usr/share/applnk/Utilities/skim.desktop" \
		"${D}/usr/share/applications/kde"

	dodoc ChangeLog AUTHORS NEWS README TODO
	mv "${D}/usr/share/doc/HTML" "${D}/usr/share/doc/${PF}/html"
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
