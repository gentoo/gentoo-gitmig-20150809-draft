# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dbus/dbus-0.13.ebuild,v 1.3 2004/02/17 22:46:07 agriffis Exp $

IUSE="doc"

S=${WORKDIR}/${P}
DESCRIPTION="A message bus system"
HOMEPAGE="http://www.freedesktop.org/software/dbus/"
SRC_URI="http://www.freedesktop.org/software/dbus/releases/${P}.tar.gz"

SLOT="0"
LICENSE="Academic"
KEYWORDS="~x86"

DEPEND="dev-libs/glib
	dev-libs/libxml2
	dev-util/pkgconfig
	doc? ( app-doc/doxygen
		app-text/openjade )"
#	qt? ( x11-libs/qt )"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	econf \
		--enable-glib \
		`use_enable doc docs`\
		--disable-qt \
		--with-initscripts=redhat || die

	# Qt bindings are currently broken -- I have this info from an email from
	# Zack Rusin <zack@kde.org>
	#	`use_enable qt` \
	make || die
}

src_install() {
	einstall || die
	keepdir /var/lib/run/dbus

	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README
}
