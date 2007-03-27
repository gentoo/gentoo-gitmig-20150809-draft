# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/boinc/boinc-5.8.15.ebuild,v 1.1 2007/03/27 05:29:11 tsunam Exp $

inherit flag-o-matic

DESCRIPTION="The Berkeley Open Infrastructure for Network Computing"
HOMEPAGE="http://boinc.ssl.berkeley.edu/"
SRC_URI="mirror://gentoo//${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="server X unicode"

RDEPEND="sys-libs/zlib
	>=net-misc/curl-7.15.5
	>=dev-libs/openssl-0.9.7
	X? ( >=x11-libs/wxGTK-2.6.2 )
	server? ( net-www/apache
		>=virtual/mysql-4.0
		virtual/php
		>=dev-lang/python-2.2.3
		>=dev-python/mysql-python-0.9.2 )"
DEPEND=">=sys-devel/gcc-3.0.4
	>=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.8
	>=dev-util/pkgconfig-0.15
	>=sys-devel/m4-1.4
	X? (	|| ( ( x11-libs/libXmu
				x11-libs/libXt
				x11-libs/libX11
				x11-proto/xproto )
			virtual/x11 )
		virtual/glut
		virtual/glu
		media-libs/jpeg )
	server? ( virtual/imap-c-client )
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	append-flags -O3 -funroll-loops -fforce-addr -ffast-math
	# Just run the necessary tools directly
	#einfo "Running necessary autotools..."
	#aclocal -I m4 || die "aclocal failed."
	#autoheader || die "autoheader failed."
	#automake || die "automake failed."
	#autoconf || die "autoconf failed."
	econf \
		--enable-client \
		--disable-static-client \
		--with-ssl \
		--with-wx-config=$(type -P wx-config-2.6) \
		$(use_enable unicode) \
		$(use_enable server) \
		$(use_with X x) || die "econf failed"
	# Make it link to the compiled libs, not the installed ones
	sed -e "s|LDFLAGS = |LDFLAGS = -L../lib |g" -i */Makefile || \
		die "sed failed"
	# Force -j1 - bug 136374.
	emake -j1 || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	mkdir ${D}/var ${D}/var/lib ${D}/var/lib/boinc/
	cp ${S}/ca-bundle.crt ${D}/var/lib/boinc
	chown boinc:boinc ${D}/var/lib/boinc
	newinitd ${FILESDIR}/boinc.init boinc
	newconfd ${FILESDIR}/boinc.conf boinc

	make_desktop_entry boinc_gui BOINC boinc Science /var/lib/boinc
}

pkg_preinst() {
	enewgroup boinc
	enewuser boinc -1 -1 /var/lib/boinc boinc
}

pkg_postinst() {
	echo
	einfo "You need to attach to a project to do anything useful with boinc."
	einfo "You can do this by running /etc/init.d/boinc attach"
	einfo "BOINC The howto for configuration is located at:"
	einfo "http://boinc.berkeley.edu/anonymous_platform.php"
	if use server;then
		echo
		einfo "You have chosen to enable server mode. this ebuild has installed"
		einfo "the necessary packages to be a server. You will need to have a"
		einfo "project. Contact BOINC directly for further information."
	fi
	echo
	# Add warning about the new password for the client, bug 121896.
	einfo "If you need to use the graphical client the password is in "
	einfo "/var/lib/boinc/gui_rpc_auth.cfg which is randomly generated "
	einfo "by BOINC upon successfully running the gui for the first time."
	einfo "You can change this to something more memorable."
	echo
}
