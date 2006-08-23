# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dbus-core/dbus-core-0.92.ebuild,v 1.3 2006/08/23 14:30:39 steev Exp $

inherit eutils multilib debug autotools

MY_P=${PN/-core/}-${PV}
DESCRIPTION="A message bus system, a simple way for applications to talk to each other"
HOMEPAGE="http://dbus.freedesktop.org/"
SRC_URI="http://dbus.freedesktop.org/releases/${MY_P}.tar.gz"

SLOT="0"
LICENSE="|| ( GPL-2 AFL-2.1 )"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="doc selinux X"

RDEPEND="X? ( || ( ( x11-libs/libXt x11-libs/libX11 ) virtual/x11 ) )
	selinux? ( sys-libs/libselinux )
	>=dev-libs/libxml2-2.6.21
	!<sys-apps/dbus-0.91"
	# expat code now sucks.. libxml2 is the default

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? (	app-doc/doxygen
		app-text/xmlto )"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf \
		$(use_with X x) \
		$(use_enable kernel_linux dnotify) \
		$(use_enable kernel_FreeBSD kqueue) \
		$(use_enable selinux) \
		$(use_enable debug verbose-mode) \
		$(use_enable debug checks) \
		$(use_enable debug asserts) \
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
	# turns out to only work for GDM. has been merged into other desktop
	# (kdm and such scripts)
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

pkg_postinst() {

	elog "To start the DBUS system-wide messagebus by default"
	elog "you should add it to the default runlevel :"
	elog "\`rc-update add dbus default\`"
	elog "Currently have it installed and running?"
	elog "Run etc-update and then run the following:"
	elog "\`/etc/init.d/dbus reload\`"
}
