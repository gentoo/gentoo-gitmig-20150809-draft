# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-3.5.2.ebuild,v 1.2 2006/05/01 19:50:53 tcort Exp $

inherit kde-dist eutils flag-o-matic

DESCRIPTION="KDE network apps: kopete, kppp, kget..."

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="rdesktop sametime slp ssl wifi xmms"

BOTH_DEPEND="~kde-base/kdebase-${PV}
	dev-libs/libxslt
	dev-libs/libxml2
	net-dns/libidn
	>=dev-libs/glib-2
	app-crypt/qca
	sametime? ( =net-libs/meanwhile-0.4* )
	xmms? ( media-sound/xmms )
	slp? ( net-libs/openslp )
	wifi? ( net-wireless/wireless-tools )
	|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrender
		x11-libs/libXScrnSaver
		) virtual/x11 )
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
			x11-proto/xextproto
			x11-proto/xproto
			kernel_linux? ( x11-libs/libXv )
			x11-proto/scrnsaverproto
		) virtual/x11 )
	dev-util/pkgconfig"

PATCHES="${FILESDIR}/kppp-3.5.0-bindnow.patch
	${FILESDIR}/lisa-3.5.0-bindnow.patch"

src_compile() {
	export BINDNOW_FLAGS="$(bindnow-flags)"

	local myconf="--with-libidn
	              $(use_enable sametime sametime-plugin)
	              $(use_enable slp) $(use_with wifi)
	              $(use_with xmms) --without-external-libgadu"

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
