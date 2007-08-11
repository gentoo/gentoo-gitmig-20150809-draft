# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-3.5.7-r1.ebuild,v 1.1 2007/08/11 20:12:08 philantrop Exp $

inherit kde-dist eutils flag-o-matic

DESCRIPTION="KDE network applications: Kopete, KPPP, KGet,..."

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="jingle kdehiddenvisibility rdesktop sametime slp ssl wifi"

SRC_URI="${SRC_URI}
	mirror://gentoo/kdenetwork-3.5-patchset-01.tar.bz2"

BOTH_DEPEND="~kde-base/kdebase-${PV}
	dev-libs/libxslt
	dev-libs/libxml2
	net-dns/libidn
	>=dev-libs/glib-2
	app-crypt/qca
	sametime? ( =net-libs/meanwhile-1.0* )
	jingle? (
		>=media-libs/speex-1.1.6
		dev-libs/expat
		~net-libs/ortp-0.7.1 )
	slp? ( net-libs/openslp )
	wifi? ( net-wireless/wireless-tools )
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	kernel_linux? ( virtual/opengl )"

RDEPEND="${BOTH_DEPEND}
	rdesktop? ( >=net-misc/rdesktop-1.4.1 )
	dev-lang/perl
	ssl? ( dev-perl/IO-Socket-SSL
		app-crypt/qca-tls )
	net-dialup/ppp
	|| ( net-misc/netkit-talk net-misc/ytalk sys-freebsd/freebsd-ubin )"

DEPEND="${BOTH_DEPEND}
	kernel_linux? ( virtual/os-headers )
	x11-proto/videoproto
	x11-proto/xproto
	kernel_linux? ( x11-libs/libXv )
	x11-proto/scrnsaverproto"

PATCHES="${FILESDIR}/kopete-3.5.5-icqfix.patch
	${FILESDIR}/kdenetwork-3.5.5-linux-headers-2.6.18.patch
	${FILESDIR}/kopete-3.5.7-videodevice.patch"

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
					$(use_enable slp) $(use_with wifi) $(use_enable jingle)
					--without-xmms --without-external-libgadu"

	kde_src_compile
}

src_install() {
	kde_src_install

	chmod u+s "${D}/${KDEDIR}/bin/reslisa"

	# empty config file needed for lisa to work with default settings
	dodir /etc
	touch "${D}/etc/lisarc"

	# lisa, reslisa initscripts
	sed -e "s:_KDEDIR_:${KDEDIR}:g" "${WORKDIR}/patches/lisa" > "${T}/lisa"
	sed -e "s:_KDEDIR_:${KDEDIR}:g" "${WORKDIR}/patches/reslisa" > "${T}/reslisa"
	doinitd "${T}/lisa" "${T}/reslisa"

	newconfd "${WORKDIR}/patches/lisa.conf" lisa
	newconfd "${WORKDIR}/patches/reslisa.conf" reslisa
}

pkg_postinst() {
	kde_pkg_postinst

	elog "If you would like to use Off-The-Record encryption with Kopete, emerge net-im/kopete-otr."

	if has_version net-misc/ytalk ; then
		elog "To use net-misc/ytalk as your local network chat program, please"
		elog "configure your system accordingly, either via the KDE control center"
		elog "or by calling \"kcmshell kcmktalkd\" on the command line."
	fi
}
