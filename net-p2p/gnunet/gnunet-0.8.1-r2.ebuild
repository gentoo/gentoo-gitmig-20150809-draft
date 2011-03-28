# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnunet/gnunet-0.8.1-r2.ebuild,v 1.3 2011/03/28 14:24:51 nirbheek Exp $

EAPI=2

inherit autotools eutils

S="${WORKDIR}/GNUnet-${PV}"
DESCRIPTION="GNUnet is an anonymous, distributed, reputation based network."
HOMEPAGE="http://gnunet.org/"
SRC_URI="http://gnunet.org/download/GNUnet-${PV}.tar.gz"
#tests don't work
RESTRICT="test"

IUSE="nls +sqlite mysql ares adns +setup ncurses gtk qt4 smtp microhttpd"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"

RDEPEND=">=dev-libs/libgcrypt-1.2.0
	>=media-libs/libextractor-0.5.18a
	>=dev-libs/gmp-4.0.0
	net-misc/curl
	sys-libs/zlib
	sqlite? ( >=dev-db/sqlite-3.0.8:3 )
	mysql? ( >=virtual/mysql-4.0 )
	!sqlite? ( !mysql? ( >=dev-db/sqlite-3.0.8:3 ) )
	setup? ( >=dev-scheme/guile-1.8.0
	  ncurses? ( >=dev-util/dialog-1.1.20080819-r1[-minimal] )
	  gtk? ( >=x11-libs/gtk+-2.6.10:2
			 gnome-base/libglade:2.0 )
	  qt4? ( x11-libs/qt-gui )
	)
	adns? ( net-libs/adns )
	ares? ( net-dns/c-ares )
	smtp? ( net-libs/libesmtp )
	!ppc? ( !ppc64? ( !sparc? ( microhttpd? ( net-libs/libmicrohttpd ) ) ) )
	nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
		sys-apps/sed
		dev-util/pkgconfig"

pkg_preinst() {
	enewgroup gnunetd
	enewuser gnunetd -1 -1 /dev/null gnunetd
}

src_prepare() {
	if ! use setup && ( use ncurses || use gtk || use qt4 ); then
		ewarn
		ewarn "You chose NOT to install setup utility. Ignoring setup frontends (ncurses, gtk, qt4)."
		ewarn
	fi

	if ! use sqlite; then
		# make mysql default sqstore if we do not compile sqlite support
		# (bug #107330)
		if use mysql; then \
			sed -i 's:default "sqstore_sqlite":default "sqstore_mysql":' \
			contrib/config-daemon.in
		else
			ewarn
			ewarn "You didn't specify preferred database (mysql or sqlite)"
			ewarn "Choosing sqlite for you."
			ewarn
		fi
	fi

	# we do not want to built gtk support with USE=-gtk
	if ! use gtk ; then
		sed -i "s:AC_DEFINE_UNQUOTED..HAVE_GTK.*:true:" configure.ac
	fi

	epatch "${FILESDIR}"/${PV}-asneeded.patch
	epatch "${FILESDIR}"/${PV}-parallel-build.patch
	epatch "${FILESDIR}"/${PV}-Fix-buffer-overflow.patch
	eautoreconf
}

src_configure() {
	local myconf

	# if neither sqlite nor mysql are chosen pick sqlite
	if ! use sqlite; then
		if use mysql; then
			myconf="${myconf} --without-sqlite"
		else
			# fallback to sqlite
			myconf="${myconf} --with-sqlite"
		fi
	fi

	# doesn't work for --with-qt4 so use_with is unusable
	use qt4 || myconf="${myconf} --without-qt"
	use mysql || myconf="${myconf} --without-mysql"

	econf \
		$(use_enable nls) \
		$(use_with gtk x) \
		$(use_with ncurses dialog) \
		$(use_with adns) \
		$(use_with ares c-ares) \
		$(use_with smtp esmtp) \
		$(use_with microhttpd) \
		$(use_with setup guile) \
		${myconf} || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS PLATFORMS README UPDATING || die
	insinto /etc
	newins contrib/gnunet.conf gnunet.conf
	docinto contrib
	dodoc contrib/* || die
	newinitd "${FILESDIR}"/${PN}.initd gnunet
	dodir /var/lib/gnunet
	chown gnunetd:gnunetd "${D}"/var/lib/gnunet
}

pkg_postinst() {
	# make sure permissions are ok
	chown -R gnunetd:gnunetd "${ROOT}"/var/lib/gnunet

	einfo
	einfo "To configure"
	einfo "	 1) Add user(s) to the gnunetd group"
	einfo "	 2) Run 'gnunet-setup' to generate your client config file"
	einfo "	 3) Run gnunet-setup -d as root to generate a server config file"
	einfo
}
