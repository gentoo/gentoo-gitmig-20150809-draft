# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dbus/dbus-0.21.ebuild,v 1.5 2004/08/10 23:06:26 foser Exp $

# because of the experimental nature debug by default
inherit debug eutils

IUSE="X gtk qt python doc"

DESCRIPTION="A message bus system"
HOMEPAGE="http://www.freedesktop.org/software/dbus/"
SRC_URI="http://www.freedesktop.org/software/dbus/releases/${P}.tar.gz"

SLOT="0"
LICENSE="Academic"
KEYWORDS="~x86 ~ppc"

RDEPEND=">=dev-libs/glib-2
	dev-libs/expat
	X? ( virtual/x11 )
	qt? ( >=x11-libs/qt-3 )
	gtk? ( >=x11-libs/gtk+-2 )
	python? ( >=dev-lang/python-2.2
		dev-python/pyrex )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen
		app-text/xmlto )"

# needs gcj, we have no neat way of knowing if it was enabled
#	java? ( sys-devel/gcc )
# mono seems broken
#	mono? ( dev-dotnet/mono )

src_compile() {

	# libxml2 support is broken
	econf \
		`use_enable X x` \
		`use_enable gtk` \
		`use_enable qt` \
		`use_enable python` \
		--enable-glib \
		--enable-verbose-mode \
		--enable-checks \
		--enable-asserts \
		--with-xml=expat \
		--with-system-pid-file=/var/run/dbus.pid \
		--with-system-socket=/var/lib/dbus/system_bus_socket \
		`use_enable doc doxygen-docs` \
		`use_enable doc xml-docs` \
		|| die

	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	# initscript
	exeinto /etc/init.d/
	doexe ${FILESDIR}/dbus

	# needs to exist for the system socket
	dodir /var/lib/dbus

#	keepdir /usr/lib/dbus-1.0/services

	if use doc ; then
		cd ${S}
		doxygen Doxyfile
		dodir /usr/share/man/man3
		mv ${S}/doc/api/man/man3/* ${D}/usr/share/man/man3
		dodir /usr/share/doc
		mv ${S}/doc/api ${D}/usr/share/doc
	fi

	dodoc AUTHORS ChangeLog HACKING NEWS README doc/TODO doc/*html

}

pkg_preinst() {

	enewgroup messagebus || die "Problem adding messagebus group"
	enewuser messagebus -1 /bin/false /dev/null messagebus || die "Problem adding messagebus user"

}

pkg_postinst() {

	einfo "To start the DBUS system-wide messagebus by default"
	einfo "you should add it to the default runlevel :"
	einfo "rc-update add dbus default"

}
