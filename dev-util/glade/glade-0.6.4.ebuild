# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-0.6.4.ebuild,v 1.3 2002/07/23 11:22:17 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="glade"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/glade/${P}.tar.gz"
HOMEPAGE="http://glade.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	bonobo? ( >=gnome-base/bonobo-1.0.9-r1 )"

RDEPEND="${RDEPEND}
	nls? ( sys-devel/gettext 
		>=dev-util/intltool-0.11 )
	>=app-text/scrollkeeper-0.2"

src_compile() {
	local myconf

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
