# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-0.6.4.ebuild,v 1.11 2003/04/12 18:06:03 foser Exp $

IUSE="nls gnome bonobo"

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="glade - GUI designer for GTK+/GNOME-1"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/glade/${P}.tar.gz"
HOMEPAGE="http://glade.gnome.org/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 sparc  ppc"

DEPEND="=x11-libs/gtk+-1.2*
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	bonobo? ( >=gnome-base/bonobo-1.0.9-r1 )"

RDEPEND="${RDEPEND}
	nls? ( sys-devel/gettext 
		>=dev-util/intltool-0.11 )
	>=app-text/scrollkeeper-0.2"

src_compile() {
	local myconf

	epatch ${FILESDIR}/${P}-autogen.sh.patch

	use gnome || myconf="--disable-gnome"

	use bonobo \
		&& myconf="${myconf} --with-bonobo" \
		|| myconf="${myconf} --without-bonobo"

	use nls || myconf="${myconf} --disable-nls"

	if [ "$DEBUG" ]
	then
		myconf="${myconf} --enable-debug"
	fi

	econf \
		--disable-gnome-db \
		${myconf}  || die

	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING* FAQ NEWS README* TODO
}
