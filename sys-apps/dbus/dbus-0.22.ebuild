# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dbus/dbus-0.22.ebuild,v 1.4 2004/09/03 21:03:23 pvdabeel Exp $

# because of the experimental nature debug by default
inherit debug eutils mono

# FIXME : fix docs
#IUSE="X gtk qt python mono doc xml2"
IUSE="X gtk qt python mono xml2"

DESCRIPTION="A message bus system, a simple way for applications to talk to eachother"
HOMEPAGE="http://www.freedesktop.org/software/dbus/"
SRC_URI="http://www.freedesktop.org/software/dbus/releases/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2 | AFL-2.1"
KEYWORDS="~x86 ppc"

RDEPEND=">=dev-libs/glib-2
	xml2? ( >=dev-libs/libxml2-2.6 )
	!xml2? ( dev-libs/expat )
	X? ( virtual/x11 )
	qt? ( >=x11-libs/qt-3 )
	gtk? ( >=x11-libs/gtk+-2 )
	python? ( >=dev-lang/python-2.2
		>=dev-python/pyrex-0.9 )
	mono? ( >=dev-dotnet/mono-0.95 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"
#	doc? ( app-doc/doxygen
#		app-text/xmlto )"

# needs gcj, we have no neat way of knowing if it was enabled
#	java? ( sys-devel/gcc )

src_compile() {

	local myconf

	if use xml2; then
		myconf="--with-xml=libxml";
	else
		myconf="--with-xml=expat";
	fi

	econf \
		`use_enable X x` \
		`use_enable gtk` \
		`use_enable qt` \
		`use_enable python` \
		`use_enable mono` \
		--enable-glib \
		--enable-verbose-mode \
		--enable-checks \
		--enable-asserts \
		--with-system-pid-file=/var/run/dbus.pid \
		--with-system-socket=/var/lib/dbus/system_bus_socket \
		--with-session-socket-dir=/tmp \
		--disable-doxygen-docs` \
		--disable-xml-docs` \
		--disable-mono-docs \
		${myconf} \
		|| die

#		`use_enable doc doxygen-docs` \
#		`use_enable doc xml-docs` \

	# do not build the mono examples, they need gtk-sharp
	touch ${S}/mono/example/echo-{server,client}.exe

	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	# initscript
	exeinto /etc/init.d/
	doexe ${FILESDIR}/dbus

	# needs to exist for the system socket
	keepdir /var/lib/dbus

	keepdir /usr/lib/dbus-1.0/services

	dodoc AUTHORS ChangeLog HACKING NEWS README doc/TODO doc/*html

}

pkg_preinst() {

	enewgroup messagebus || die "Problem adding messagebus group"
	enewuser messagebus -1 /bin/false /dev/null messagebus || die "Problem adding messagebus user"

}

pkg_postinst() {

	einfo "To start the DBUS system-wide messagebus by default"
	einfo "you should add it to the default runlevel :"
	einfo "\`rc-update add dbus default\`"

}
