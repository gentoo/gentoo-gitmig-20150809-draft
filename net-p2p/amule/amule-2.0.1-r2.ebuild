# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/amule/amule-2.0.1-r2.ebuild,v 1.3 2006/04/24 15:17:13 squinky86 Exp $

inherit eutils flag-o-matic wxwidgets

MY_P=${P/m/M}
S=${WORKDIR}/${MY_P}

DESCRIPTION="aMule, the all-platform eMule p2p client"
HOMEPAGE="http://www.amule.org/"
SRC_URI="http://download.berlios.de/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~ppc64 ~sparc ~alpha"
IUSE="amuled debug nls remote stats unicode"


DEPEND=">=x11-libs/wxGTK-2.6.0
	>=sys-libs/zlib-1.2.2
	nls? ( sys-devel/gettext )
	remote? ( >=media-libs/libpng-1.2.8 )
	stats? ( >=media-libs/gd-2.0.32 )
	!net-p2p/xmule
	sys-apps/sed"

pkg_setup() {
	export WX_GTK_VER="2.6"
	if use unicode; then
		need-wxwidgets unicode
	else
		need-wxwidgets gtk2
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
	if use amuled; then
		EXTRA_ECONF="--enable-amule-daemon --enable-amule-gui"
	fi

	econf \
		--disable-optimize \
		--with-wx-config=${WX_CONFIG} \
		--with-wxbase-config=${WX_CONFIG} \
		`use_enable debug` \
		`use_enable nls` \
		`use_enable remote amulecmd` \
		`use_enable remote amulecmdgui` \
		`use_enable remote webserver` \
		`use_enable remote webservergui` \
		`use_enable stats cas` \
		`use_enable stats wxcas` \
		`use_enable stats alc` \
		`use_enable stats alcc` \
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
