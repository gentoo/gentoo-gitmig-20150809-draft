# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/amule/amule-2.0.3-r4.ebuild,v 1.10 2006/04/24 15:17:13 squinky86 Exp $

inherit eutils flag-o-matic wxwidgets

MY_P=${P/m/M}
S=${WORKDIR}/${MY_P}

DESCRIPTION="aMule, the all-platform eMule p2p client"
HOMEPAGE="http://www.amule.org/"
SRC_URI="http://download.berlios.de/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 ~sparc x86"
IUSE="amuled debug nls remote stats unicode gtk"


DEPEND=">=x11-libs/wxGTK-2.6.0
	>=sys-libs/zlib-1.2.2
	nls? ( sys-devel/gettext )
	remote? ( >=media-libs/libpng-1.2.8 )
	stats? ( >=media-libs/gd-2.0.32 )
	!net-p2p/xmule
	sys-apps/sed"

pkg_setup() {
	export WX_GTK_VER="2.6"
	if use unicode && use gtk; then
		need-wxwidgets unicode
	elif use gtk; then
		need-wxwidgets gtk2
	elif use unicode; then
		need-wxwidgets base-unicode
	else
		need-wxwidgets base
	fi

	if ! use gtk && ! use remote && ! use amuled; then
		eerror "You have to specify at least on of gtk, remote and amuled"
		eerror "USE flag to build amule"
		die "Invalid USE flag set"
	fi

	if use stats && ! built_with_use media-libs/gd jpeg; then
		die "media-libs/gd should be compiled with the jpeg use flag when you have the stats use flag set"
	fi
}

pkg_preinst() {
	if use amuled || use remote; then
		if ! id p2p >/dev/null; then
			enewgroup p2p
			enewuser p2p -1 -1 /home/p2p p2p
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -r "s:\\$\\(LN_S\\) (.*):\$\(LN_S\) ${D}/\1:g" docs/man/Makefile.in
}

src_compile() {
	local myconf

	if use gtk; then
		myconf="--enable-amule-gui"
		use stats && myconf="${myconf}
			--enable-wxcas
			--enable-alc"
		use remote && myconf="${myconf}
			--enable-amulecmdgui
			--enable-webservergui"
	else
		myconf="--disable-monolithic"
	fi

	econf \
		--disable-optimize \
		--with-wx-config=${WX_CONFIG} \
		--with-wxbase-config=${WX_CONFIG} \
		`use_with gtk x` \
		`use_enable amuled amule-daemon` \
		`use_enable debug` \
		`use_enable nls` \
		`use_enable remote amulecmd` \
		`use_enable remote webserver` \
		`use_enable stats cas` \
		`use_enable stats alcc` \
		${myconf} \
		|| die
	# we filter ssp until bug #74457 is closed to build on hardened
	if has_hardened; then
	filter-flags -fstack-protector -fstack-protector-all
	fi
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die

	if use amuled; then
	        insinto /etc/conf.d; newins ${FILESDIR}/amuled.confd amuled
	        exeinto /etc/init.d; newexe ${FILESDIR}/amuled.initd amuled
	fi

	if use remote; then
	        insinto /etc/conf.d; newins ${FILESDIR}/amuleweb.confd amuleweb
	        exeinto /etc/init.d; newexe ${FILESDIR}/amuleweb.initd amuleweb
	fi
}
