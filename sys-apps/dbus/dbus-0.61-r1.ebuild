# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dbus/dbus-0.61-r1.ebuild,v 1.12 2006/10/20 21:03:23 agriffis Exp $

inherit eutils mono python multilib debug qt3 autotools

DESCRIPTION="A message bus system, a simple way for applications to talk to each other"
HOMEPAGE="http://dbus.freedesktop.org/"
SRC_URI="http://dbus.freedesktop.org/releases/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( GPL-2 AFL-2.1 )"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE="doc gtk mono python qt3 selinux X"

RDEPEND=">=dev-libs/glib-2.6
	X? ( || ( ( x11-libs/libXt x11-libs/libX11 ) virtual/x11 ) )
	gtk? ( >=x11-libs/gtk+-2.6 )
	mono? ( >=dev-lang/mono-0.95 )
	python? ( >=dev-lang/python-2.4 >=dev-python/pyrex-0.9.3-r2 )
	qt3? ( $(qt_min_version 3.3) )
	selinux? ( sys-libs/libselinux )
	>=dev-libs/libxml2-2.6.21"
	# expat code now sucks.. libxml2 is the default

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? (	app-doc/doxygen
		app-text/xmlto
		mono? ( >=dev-util/monodoc-1.1.10 ) )"

pkg_setup() {
	PKG_CONFIG_PATH="${QTDIR}/lib/pkgconfig"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix .pc file for QT
	epatch "${FILESDIR}"/${PN}-0.60-qt-pc.patch

	# Fix GLIB Declaration for ANSI C
	epatch "${FILESDIR}"/${PN}-0.60-decls-ansi-c.patch

	#fix mono-tools depend
	epatch "${FILESDIR}"/${PN}-0.61-mono-tools-update.diff

	#fix qt4 disabling
	epatch "${FILESDIR}"/${PN}-0.61-qt-disabling.patch

	#fix Trolltech's Makefile blunder
	epatch "${FILESDIR}"/${PN}-0.61-i-hate-qt-so-much.patch

	#fix libxml dep
	epatch "${FILESDIR}"/${PN}-0.61-libxml-dep.patch

	#fix mono return null
	epatch "${FILESDIR}"/${PN}-0.60-mono-return-null-fix.diff

	eautoreconf
}

src_compile() {
	local myconf=""

	# Only enable mono-docs if both mono and doc is defined
	use mono && myconf="${myconf} $(use_enable doc mono-docs)"

	if use qt3; then
		myconf="${myconf} --enable-qt3=${QTDIR} --with-qt-moc=/usr/bin/moc --with-qt3-moc=${QTDIR}/bin/moc --disable-qt"
	else
		myconf="${myconf} --disable-qt --disable-qt3 --without-qt-moc --without-qt3-moc"
	fi

	econf \
		$(use_with X x) \
		$(use_enable gtk) \
		$(use_enable python) \
		$(use_enable mono) \
		$(use_enable kernel_linux dnotify) \
		--disable-gcj \
		$(use_enable selinux) \
		$(use_enable debug verbose-mode) \
		$(use_enable debug checks) \
		$(use_enable debug asserts) \
		--enable-glib \
		--with-xml=libxml \
		--with-system-pid-file=/var/run/dbus.pid \
		--with-system-socket=/var/run/dbus/system_bus_socket \
		--with-session-socket-dir=/tmp \
		--with-dbus-user=messagebus \
		--localstatedir=/var \
		$(use_enable doc doxygen-docs) \
		--disable-xml-docs \
		${myconf} \
		|| die "econf failed"

	# Don't build the mono examples, they require gtk-sharp
	touch ${S}/mono/example/{bus-listener,echo-{server,client}}.exe

	# after the compile, it uses a selinuxfs interface to
	# check if the SELinux policy has the right support
	use selinux && addwrite /selinux/access

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# initscript
	newinitd "${FILESDIR}"/dbus.init-0.61 dbus

	# dbus X session script (#77504)
	# FIXME : turns out to only work for GDM, better solution needed
	exeinto /etc/X11/xinit/xinitrc.d/
	doexe "${FILESDIR}"/30-dbus

	# needs to exist for the system socket
	keepdir /var/run/dbus

	keepdir /usr/lib/dbus-1.0/services
	keepdir /usr/share/dbus-1/services

	dodoc AUTHORS ChangeLog HACKING NEWS README doc/TODO
	if use doc; then
		dohtml doc/*html
	fi
}

pkg_preinst() {
	enewgroup messagebus || die "Problem adding messagebus group"
	enewuser messagebus -1 "-1" -1 messagebus || die "Problem adding messagebus user"
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/lib/python*/site-packages/dbus
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"/usr/lib/python*/site-packages/dbus

	einfo "To start the DBUS system-wide messagebus by default"
	einfo "you should add it to the default runlevel :"
	einfo "\`rc-update add dbus default\`"
	echo
	einfo "Run etc-update and then run the following:"
	einfo "\`/etc/init.d/dbus reload\`"
}
