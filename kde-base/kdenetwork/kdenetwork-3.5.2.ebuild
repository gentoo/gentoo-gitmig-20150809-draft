# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-3.5.2.ebuild,v 1.18 2006/12/01 19:10:05 flameeyes Exp $

inherit kde-dist eutils flag-o-matic

DESCRIPTION="KDE network apps: kopete, kppp, kget..."

KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE="kdehiddenvisibility rdesktop sametime slp ssl wifi"

BOTH_DEPEND="~kde-base/kdebase-${PV}
	dev-libs/libxslt
	dev-libs/libxml2
	net-dns/libidn
	>=dev-libs/glib-2
	app-crypt/qca
	sametime? ( =net-libs/meanwhile-0.4* )
	slp? ( net-libs/openslp )
	wifi? ( net-wireless/wireless-tools )
	|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrender
		x11-libs/libXScrnSaver
		) <virtual/x11-7 )
	kernel_linux? ( virtual/opengl )"

RDEPEND="${BOTH_DEPEND}
	rdesktop? ( >=net-misc/rdesktop-1.4.1 )
	dev-lang/perl
	ssl? ( dev-perl/IO-Socket-SSL
		app-crypt/qca-tls )"

DEPEND="${BOTH_DEPEND}
	kernel_linux? ( virtual/os-headers )
	|| ( (
			x11-proto/videoproto
			x11-proto/xproto
			kernel_linux? ( x11-libs/libXv )
			x11-proto/scrnsaverproto
		) <virtual/x11-7 )
	dev-util/pkgconfig"

PATCHES="${FILESDIR}/kppp-3.5.0-bindnow.patch
	${FILESDIR}/lisa-3.5.0-bindnow.patch"

pkg_setup() {
	if use kernel_linux && ! built_with_use =x11-libs/qt-3* opengl; then
		eerror "To support Video4Linux webcams in this package is required to have"
		eerror "=x11-libs/qt-3* compiled with OpenGL support."
		eerror "Please reemerge =x11-libs/qt-3* with USE=\"opengl\"."
		die "Please reemerge =x11-libs/qt-3* with USE=\"opengl\"."
	fi
}

src_compile() {
	export BINDNOW_FLAGS="$(bindnow-flags)"

	local myconf="--with-libidn
				  $(use_enable sametime sametime-plugin)
				  $(use_enable slp) $(use_with wifi)
				  --without-xmms --without-external-libgadu"

	kde_src_compile
}

src_install() {
	kde_src_install

	chmod u+s ${D}/${KDEDIR}/bin/reslisa

	# empty config file needed for lisa to work with default settings
	dodir /etc
	touch ${D}/etc/lisarc

	# lisa, reslisa initscripts
	sed -e "s:_KDEDIR_:${KDEDIR}:g" ${FILESDIR}/lisa > ${T}/lisa
	sed -e "s:_KDEDIR_:${KDEDIR}:g" ${FILESDIR}/reslisa > ${T}/reslisa
	exeinto /etc/init.d
	doexe ${T}/lisa ${T}/reslisa

	insinto /etc/conf.d
	newins ${FILESDIR}/lisa.conf lisa
	newins ${FILESDIR}/reslisa.conf reslisa
}

pkg_postinst() {
	elog "Since 11 July 2006 the version of Kopete here built cannot connect to ICQ service"
	elog "anymore."
	elog "You're currently invited to use either >=kde-base/kopete-3.5.3-r2, >=net-im/kopete-0.12.0-r2"
	elog "or >=kde-base/kdenetwork-3.5.2-r2 that are patched to support the new authentication."
	elog "For more information, please look at the following bugs:"
	elog "	  http://bugs.kde.org/show_bug.cgi?id=130630"
	elog "	  http://bugs.gentoo.org/show_bug.cgi?id=140009"
}
