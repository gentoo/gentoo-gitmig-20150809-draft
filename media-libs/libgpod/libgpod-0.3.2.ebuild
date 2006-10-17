# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgpod/libgpod-0.3.2.ebuild,v 1.3 2006/10/17 19:49:25 tester Exp $

inherit eutils

DESCRIPTION="Shared library to access the contents of an iPod"
HOMEPAGE="http://www.gtkpod.org/libgpod.html"
SRC_URI="mirror://sourceforge/gtkpod/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc ~x86"
IUSE="hal gtk"

RDEPEND=">=dev-libs/glib-2.4
		gtk? ( >=x11-libs/gtk+-2 )
		hal? ( >=sys-apps/dbus-0.5.2
				>=sys-apps/hal-0.5
				>=sys-apps/pmount-0.9.6 )
		virtual/eject"
DEPEND="${RDEPEND}
		sys-devel/autoconf
		sys-devel/libtool
		sys-devel/automake
		dev-util/pkgconfig
		>=dev-util/intltool-0.2.9"
src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-0.3.0-config-enables.diff
	autoreconf
	libtoolize --force --copy
}

src_compile() {

	local myconf=""

	myconf="${myconf}
		$(use_enable hal)
		$(use_enable gtk gdk-pixbuf)"

	if use hal ; then
		myconf="${myconf} --with-eject-comand=/usr/bin/eject \
						--with-unmount-command=/usr/bin/pumount"
	else
	myconf="${myconf}
		--with-eject-command=/usr/bin/eject \
		--with-unmount-command=/bin/umount"
	fi

	econf \
	${myconf} \
	|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc README
}

