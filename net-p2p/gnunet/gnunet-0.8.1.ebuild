# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnunet/gnunet-0.8.1.ebuild,v 1.3 2011/03/28 14:24:51 nirbheek Exp $

EAPI=2

inherit autotools eutils

S="${WORKDIR}/GNUnet-${PV}"
DESCRIPTION="GNUnet is an anonymous, distributed, reputation based network."
HOMEPAGE="http://gnunet.org/"
SRC_URI="http://gnunet.org/download/GNUnet-${PV}.tar.gz"
#tests don't work
RESTRICT="test"

IUSE="gtk mysql nls +sqlite"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=dev-libs/libgcrypt-1.2.0
	>=media-libs/libextractor-0.5.18a
	>=dev-libs/gmp-4.0.0
	gnome-base/libglade:2.0
	sys-libs/zlib
	net-misc/curl
	gtk? ( >=x11-libs/gtk+-2.6.10:2 )
	sys-apps/sed
	>=dev-scheme/guile-1.8.0
	sys-libs/ncurses
	mysql? ( >=virtual/mysql-4.0 )
	sqlite? ( >=dev-db/sqlite-3.0.8:3 )
	nls? ( sys-devel/gettext )"

pkg_setup() {
	if ! use mysql && ! use sqlite; then
		einfo
		einfo "You need to specify at least one of 'mysql' or 'sqlite'"
		einfo "USE flag in order to have properly installed gnunet"
		einfo
		die "Invalid USE flag set"
	fi
}

pkg_preinst() {
	enewgroup gnunetd
	enewuser gnunetd -1 -1 /dev/null gnunetd
}

src_prepare() {
	# make mysql default sqstore if we do not compile sqlite support
	# (bug #107330)
	! use sqlite && \
		sed -i 's:default "sqstore_sqlite":default "sqstore_mysql":' \
		contrib/config-daemon.in

	# we do not want to built gtk support with USE=-gtk
	if ! use gtk ; then
		sed -i "s:AC_DEFINE_UNQUOTED..HAVE_GTK.*:true:" configure.ac
	fi

	epatch "${FILESDIR}"/${PV}-asneeded.patch
	epatch "${FILESDIR}"/${PV}-parallel-build.patch
	eautoreconf
}

src_configure() {
	local myconf

	use mysql || myconf="${myconf} --without-mysql"

	econf \
		$(use_with sqlite) \
		$(use_enable nls) \
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
