# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dbus/dbus-0.23.4-r1.ebuild,v 1.16 2006/04/09 16:56:28 steev Exp $

# because of the experimental nature debug by default
inherit debug eutils mono python multilib qt3

# FIXME : fix docs
#IUSE="X gtk qt python mono doc xml"
IUSE="X gtk qt python mono xml"

DESCRIPTION="A message bus system, a simple way for applications to talk to eachother"
HOMEPAGE="http://dbus.freedesktop.org/"
SRC_URI="http://dbus.freedesktop.org/releases/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( GPL-2 AFL-2.1 )"
KEYWORDS="amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86"

RDEPEND=">=dev-libs/glib-2
	xml? ( >=dev-libs/libxml2-2.6 )
	!xml? ( dev-libs/expat )
	X? (
		|| (
			(
				x11-libs/libXt
				x11-libs/libX11 )
			virtual/x11 ) )
	gtk? ( >=x11-libs/gtk+-2 )
	python? ( >=dev-lang/python-2.2
		>=dev-python/pyrex-0.9 )
	qt? ( $(qt_min_version 3.3) )
	!ppc64? (
		mono? ( >=dev-lang/mono-0.95 )
	)"


DEPEND="${RDEPEND}
	dev-util/pkgconfig"
#	doc? ( app-doc/doxygen
#		app-text/xmlto )"

# needs gcj, we have no neat way of knowing if it was enabled
#	java? ( sys-devel/gcc )

src_unpack() {

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-0.23-qt.patch
	# add missing include (#78617)
	epatch ${FILESDIR}/${PN}-0.23-fd_set.patch
	# workaround mono lib versioning (#81794)
	epatch ${FILESDIR}/${PN}-0.23.2-version_fix.patch

	# It stupidly tries to install python stuff to platform-independent
	# libdir
	epatch ${FILESDIR}/dbus-0.23-pyexecdir.patch

	# Don't rerun auto*
	sleep 1
	touch ${S}/python/Makefile.in
	sleep 1
	touch ${S}/configure

}

src_compile() {

	local myconf

	if use xml; then
		myconf="--with-xml=libxml";
	else
		myconf="--with-xml=expat";
	fi

	if use qt; then
		myconf="${myconf} --enable-qt=${QTDIR} QT_MOC=${QTDIR}/bin/moc"
	else
		myconf="${myconf} --disable-qt"
	fi

	econf \
		--localstatedir=/var \
		`use_with X x` \
		`use_enable gtk` \
		`use_enable qt` \
		`use_enable python` \
		`use_enable mono` \
		--enable-glib \
		--enable-verbose-mode \
		--enable-checks \
		--enable-asserts \
		--with-system-socket=/var/run/dbus/system_bus_socket \
		--with-system-pid-file=/var/run/dbus.pid \
		--with-session-socket-dir=/tmp \
		--disable-doxygen-docs \
		--disable-xml-docs \
		--disable-mono-docs \
		${myconf} \
		|| die

#		`use_enable doc doxygen-docs` \
#		`use_enable doc xml-docs` \

	# do not build the mono examples, they need gtk-sharp
	touch ${S}/mono/example/{bus-listener,echo-{server,client}}.exe

	# this gets around a lib64 sandbox bug. note that this addpredict is
	# added automatically by sandbox.c for lib.
	addpredict /usr/lib64/python2.3/
	addpredict /usr/lib64/python2.2/
	addpredict /usr/lib64/python2.1/

	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	# initscript
	exeinto /etc/init.d/
	doexe ${FILESDIR}/dbus

	# dbus X session script (#77504)
	# FIXME : turns out to only work for GDM, better solution needed
	exeinto /etc/X11/xinit/xinitrc.d/
	doexe ${FILESDIR}/30-dbus

	# needs to exist for the system socket
	keepdir /var/run/dbus

	keepdir /usr/lib/dbus-1.0/services
	keepdir /usr/share/dbus-1/services

	dodoc AUTHORS ChangeLog HACKING NEWS README doc/TODO doc/*html

}

pkg_preinst() {

	enewgroup messagebus || die "Problem adding messagebus group"
	enewuser messagebus -1 "-1" /dev/null messagebus || die "Problem adding messagebus user"

}

pkg_postinst() {

	einfo "To start the DBUS system-wide messagebus by default"
	einfo "you should add it to the default runlevel :"
	einfo "\`rc-update add dbus default\`"

}
