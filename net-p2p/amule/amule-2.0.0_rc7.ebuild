# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/amule/amule-2.0.0_rc7.ebuild,v 1.1 2004/10/20 03:06:13 squinky86 Exp $

inherit wxwidgets

MY_P=${P/m/M}
MY_P=${MY_P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="aMule, the all-platform eMule p2p client"
HOMEPAGE="http://www.amule.org/"
SRC_URI="http://download.berlios.de/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug gtk2 nls remote stats unicode gd"

DEPEND="remote? ( =x11-libs/wxGTK-2.4* )
	!remote? ( >=x11-libs/wxGTK-2.4.2-r2 )
	>=net-misc/curl-7.11.0
	>=sys-libs/zlib-1.2.1
	stats? ( >=media-libs/gd-2.0.26 )
	gd? ( >=media-libs/gd-2.0.26 )
	!net-p2p/xmule"

pkg_setup() {

	if use gtk2 >& /dev/null && use remote >& /dev/null ; then
		die "aMule remote utilities don't work with wxGTK 2.5 so use either USE='remote' or USE='gtk2'"
	fi

	need-wxwidgets gtk

	if ${WX_CONFIG} --version | grep 2.4 >& /dev/null ; then
		if use gtk2 >& /dev/null || use unicode >& /dev/null ; then
			einfo "Compiling ${PN} against wxGTK2 2.4.x is not supported."
			einfo "You can upgrade wxGTK to development snapshot 2.5.*"
			einfo "but this will break other applications, or emerge amule"
			einfo "with USE=\"-gtk2 -unicode\"."
			die "Emerge amule with USE=\"-gtk2 -unicode\"."
		fi
	else
		if ! use gtk2 >& /dev/null ; then
			need-wxwidgets gtk || die "gtk version of x11-libs/wxGTK not found"
		elif use unicode >& /dev/null ; then
			need-wxwidgets unicode || die "You need to emerge unicoded wxGTK with USE='gtk2 unicode'"
		else
			need-wxwidgets gtk2 || die "You need to emerge wxGTK with USE='gtk2'"
		fi
	fi
}

src_compile() {
	econf \
		--enable-optimise \
		--with-wx-config=${WX_CONFIG} \
		--with-wxbase-config=${WX_CONFIG} \
		`use_enable nls` \
		`use_enable remote amulecmd` \
		`use_enable remote amulecmdgui` \
		`use_enable remote webserver` \
		`use_enable remote webservergui` \
		`use_enable stats cas` \
		`use_enable stats wxcas` \
		`use_enable stats alc` \
		`use_enable stats alcc` \
		`use_enable debug` || die

	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
}
