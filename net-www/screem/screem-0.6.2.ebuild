# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/screem/screem-0.6.2.ebuild,v 1.1 2003/04/20 02:57:18 darkspecter Exp $

IUSE="ssl zlib"

S=${WORKDIR}/${P}
DESCRIPTION="SCREEM (Site CReating and Editing EnvironmenMent) is an
integrated environment of the creation and maintenance of websites and
pages"
SRC_URI="http://ftp1.sourceforge.net/screem/${P}.tar.gz"
HOMEPAGE="http://www.screem.org"
KEYWORDS="~x86 ~sparc ~ppc "
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=gnome-base/gnome-2.0.2
	>=dev-libs/libxml2-2.4.3
	>=gnome-base/libglade-1.99.2
	>=gnome-base/gnome-vfs-2.0
	>=gnome-base/libgnomeprint-1.110.0
	>=gnome-base/libgnomeprintui-1.110.0
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )"

src_compile() {

	local myconf=""
	
	
	use ssl && myconf="$myconf --with-ssl"
	
	use zlib || myconf="$myconf --without-zlib"

	econf ${myconf} || die "Configuration Failure"
	
	emake || die "Compilation Failure"
}

src_install () {
	addwrite /var/lib/scrollkeeper/
	make DESTDIR=${D} install

#	einstall || die "Installation Failure"
	
	dodoc ABOUT-NLS AUTHORS BUGS ChangeLog INSTALL NEWS README TODO

	einfo "If you want to have http and WebDAV support you should"
	einfo "emerge net-misc/neon and remerge screem."
}
