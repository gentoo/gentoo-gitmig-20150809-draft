# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/control-center/control-center-1.4.0.5-r2.ebuild,v 1.8 2006/09/05 01:38:38 kumba Exp $

inherit gnome.org eutils multilib gnome2

DESCRIPTION="The GNOME control-center"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ppc ppc64 sparc x86"
IUSE="nls"

RDEPEND="<gnome-base/gnome-vfs-1.9.0
	>=media-libs/gdk-pixbuf-0.11.0-r1"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=dev-util/intltool-0.11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-cflags.patch


	# fix bug #102894
	strip-linguas -i po
	gnome2_omf_fix
}

src_compile() {
	local myconf

	if ! use nls
	then
		myconf="--disable-nls"
	fi

	# Fix build agains gdk-pixbuf-0.12 and later
	#	CFLAGS="${CFLAGS} `gdk-pixbuf-config --cflags`"
	# Not needed anymore? uncomment if this bugs.

	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --mandir=/usr/share/man \
		    --sysconfdir=/etc \
		    --localstatedir=/var/lib \
			--libdir=/usr/$(get_libdir) \
		    ${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib	\
		libdir=${D}/usr/$(get_libdir) \
		install || die
	dodoc AUTHORS ChangeLog README NEWS
}
