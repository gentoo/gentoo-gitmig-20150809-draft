# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dialog/dialog-1.1.20110707-r1.ebuild,v 1.5 2011/12/10 02:35:59 naota Exp $

EAPI="2"

inherit multilib

MY_PV="${PV/1.1./1.1-}"
S=${WORKDIR}/${PN}-${MY_PV}
DESCRIPTION="tool to display dialog boxes from a shell"
HOMEPAGE="http://invisible-island.net/dialog/dialog.html"
SRC_URI="ftp://invisible-island.net/${PN}/${PN}-${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="examples minimal nls static-libs unicode"

RDEPEND="
	>=app-shells/bash-2.04-r3
	!unicode? ( >=sys-libs/ncurses-5.2-r5 )
	unicode? ( >=sys-libs/ncurses-5.2-r5[unicode] )
"
DEPEND="
	${RDEPEND}
	nls? ( sys-devel/gettext )
	!minimal? ( sys-devel/libtool )
	!<=sys-freebsd/freebsd-contrib-8.9999
"

src_prepare() {
	sed -i configure -e '/LIB_CREATE=/s:${CC}:& ${LDFLAGS}:g' || die
}

src_configure() {
	local ncursesw
	use unicode && ncursesw="w"
	econf \
		$(use_enable nls) \
		$(use_with !minimal libtool) \
		--with-ncurses${ncursesw}
}

src_install() {
	if use minimal; then
		emake DESTDIR="${D}" install || die "install failed"
	else
		emake DESTDIR="${D}" install-full || die "install failed"
	fi

	dodoc CHANGES README VERSION

	if use examples; then
		docinto samples
		dodoc samples/*
	fi

	if ! use static-libs; then
		rm -f \
			"${D}"usr/$(get_libdir)/libdialog.a \
			"${D}"usr/$(get_libdir)/libdialog.la
	fi
}
