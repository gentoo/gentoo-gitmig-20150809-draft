# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnunet/gnunet-0.7.1b.ebuild,v 1.2 2007/03/25 11:02:24 armin76 Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils autotools

S="${WORKDIR}/GNUnet-${PV}"
DESCRIPTION="GNUnet is an anonymous, distributed, reputation based network."
HOMEPAGE="http://gnunet.org/"
SRC_URI="http://gnunet.org/download/GNUnet-${PV}.tar.bz2"
#tests don't work
RESTRICT="test"

IUSE="ipv6 mysql sqlite ncurses nls gtk"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=dev-libs/libgcrypt-1.2.0
	>=media-libs/libextractor-0.5.13
	>=dev-libs/gmp-4.0.0
	sys-libs/zlib
	gtk? ( >=x11-libs/gtk+-2.6.10 )
	sys-apps/sed
	>=dev-scheme/guile-1.8.0
	ncurses? ( sys-libs/ncurses )
	mysql? ( >=virtual/mysql-4.0 )
	sqlite? ( >=dev-db/sqlite-3.0.8 )
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
	enewgroup gnunetd || die "Problem adding gnunetd group"
	enewuser gnunetd -1 -1 /dev/null gnunetd || die "Problem adding gnunetd user"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# make mysql default sqstore if we do not compile sql support
	# (bug #107330)
	! use sqlite && \
		sed -i 's:default "sqstore_sqlite":default "sqstore_mysql":' \
		contrib/config-daemon.in

	# we do not want to built gtk support with USE=-gtk
	if ! use gtk ; then
		sed -i "s:AC_DEFINE_UNQUOTED..HAVE_GTK.*:true:" configure.ac
	fi

	AT_M4DIR="${S}/m4" eautoreconf
}

src_compile() {
	local myconf

	if use ipv6; then
		if use amd64; then
			ewarn "ipv6 in GNUnet does not currently work with amd64 and has been disabled"
		else
			myconf="${myconf} --enable-ipv6"
		fi
	fi

	use mysql || myconf="${myconf} --without-mysql"

	econf \
		$(use_with sqlite) \
		$(use_enable nls) \
		$(use_enable ncurses) \
		$(use_enable guile) \
		${myconf} || die "econf failed"

	emake -j1 || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING INSTALL NEWS PLATFORMS README	README.fr UPDATING
	insinto /etc
	newins contrib/gnunet.root gnunet.conf
	docinto contrib
	dodoc contrib/*
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PN}-2 gnunet
	dodir /var/lib/gnunet
	chown gnunetd:gnunetd ${D}/var/lib/gnunet
}

pkg_postinst() {
	# make sure permissions are ok
	chown -R gnunetd:gnunetd /var/lib/gnunet

	use ipv6 && ewarn "ipv6 support is -very- experimental and prone to bugs"
	einfo
	einfo "To configure"
	einfo "	 1) Add user(s) to the gnunetd group"
	einfo "	 2) Run 'gnunet-setup' to generate your client config file"
	einfo "	 3) Run gnunet-setup -d to generate a server config file"
	einfo "	 4) Optionally copy the .gnunet/gnunetd.conf into /etc and"
	einfo "\tuse as a global server config file:"
	einfo "$ gnunet-setup -d"
	einfo "# cp ~/.gnunet/gnunetd.conf /etc/"
	einfo
}

