# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libglade/libglade-0.17-r4.ebuild,v 1.1 2002/03/30 01:02:51 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libglade allows programmes to load their UIs from an XMLS description at tuntime."
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://freshmeat.net/redir/libglade/5651/url_homepage/"

RDEPEND=">=dev-libs/libxml-1.8.15
	 gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	 bonobo? ( >=gnome-base/bonobo-1.0.19-r1 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	local myopts

# Bonobo support creates a circular depend // Hallski
	use bonobo	\
		&& myconf="${myconf} --enable-bonobo"	\
		|| myconf="${myconf} --disable-bonobo --disable-bonobotest"

	use nls || myconf="${myconf} --disable-nls"

	use gnome	\
		&& myconf="${myconf} --with-gnome --enable-gnomedb"	\
		|| myconf="${myconf} --without-gnome --disable-gnomedb"

	./configure --host=${CHOST}					\
		--prefix=/usr					\
		--sysconfdir=/etc					\
		--localstatedir=/var/lib				\
		--disable-gnomedb					\
		--disable-bonobo --disable-bonobotest		\
		${myconf} || die
	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die
	
	dodoc AUTHORS COPYING* ChangeLog NEWS
	dodoc doc/*.txt
}
