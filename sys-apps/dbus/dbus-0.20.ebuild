# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dbus/dbus-0.20.ebuild,v 1.3 2004/02/17 22:46:07 agriffis Exp $

IUSE="doc xml mono gtk X qt gtk python"

S=${WORKDIR}/${P}
DESCRIPTION="A message bus system"
HOMEPAGE="http://www.freedesktop.org/software/dbus/"
SRC_URI="http://www.freedesktop.org/software/dbus/releases/${P}.tar.gz"

SLOT="0"
LICENSE="Academic"
KEYWORDS="~x86"

DEPEND="
	dev-libs/glib
	dev-libs/libxml2
	dev-util/pkgconfig
	X? ( x11-base/xfree )
	qt? ( >=x11-libs/qt-3.2.3 )
	doc? ( app-doc/doxygen
		app-text/openjade
		xml? ( app-text/xmlto )
	)
	gtk? ( >=x11-libs/gtk+-2.2.1
	mono? ( dev-dotnet/mono )
		>=x11-libs/gtk+-1.2.10-r10 )
	python? ( dev-python/pyrex )"

src_compile() {
	local myconf

	if use doc
	then
		myconf="${myconf} --enable-doxygen-docs"

		if use xml
		then
			myconf="${myconf} --enable-xml-docs"
		else
			myconf="${myconf} --disable-xml-docs"
		fi
	else
		myconf="${myconf} --disable-doxygen-docs --disable-xml-docs"
	fi

	econf \
		`use_with X x` \
		`use_enable gtk` \
		--enable-glib \
		--enable-checks \
		--disable-qt \
		--disable-python \
		--with-xml=expat \
		--with-initscripts=redhat \
		${myconf} || die

	# java/gcj will require portage to know about use information in the
	# dependency (in this case gcc)

	# python bindings are broken

	# mono bindings a little muddled -- being looked into
	# James William Dumay <i386@sauceage.org>
		#`use_enable mono` \
	# Expat used as XML Parser because libxml breaks build -- being looked into
	# James William Dumay <i386@sauceage.org>

	# checks API is sane (--enable-checks)
	# James William Dumay <i386@sauceage.org>

	# Qt bindings are currently broken -- I have this info from an email from
	# Zack Rusin <zack@kde.org>
		#use_enable qt \
	emake || die
}

src_install() {
	einstall || die
	keepdir /var/lib/run/dbus
	keepdir /usr/lib/dbus-1.0/services

	dosed "s:${T}:/tmp:" /etc/dbus-1/session.conf

	dodoc AUTHORS ChangeLog HACKING NEWS README
}
