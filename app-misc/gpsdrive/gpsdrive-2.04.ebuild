# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gpsdrive/gpsdrive-2.04.ebuild,v 1.5 2004/02/21 00:33:27 mr_bones_ Exp $

DESCRIPTION="displays GPS position on a map"
HOMEPAGE="http://gpsdrive.kraftvoll.at"
SRC_URI="http://gpsdrive.kraftvoll.at/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc ~sparc ~alpha ~hppa"

IUSE="nls"
DEPEND="sys-devel/gettext
	>=x11-libs/gtk+-2.0
	>=dev-libs/libpcre-4.2"


src_unpack() {
	unpack ${A}
	cd ${S}
	#mv configure configure.orig
	#sed -e "s:^CFLAGS=\"-O2 -Wall\":CFLAGS=${CFLAGS}:" \
		#-e "s:^CXXFLAGS=\"\$CFLAGS\":CXXFLAGS=${CXXFLAGS}:" \
		##configure.orig > configure
	#chmod +x configure

}

src_compile() {
	econf `use_enable nls`
	emake || die "compile failed"

}

src_install() {
	make DESTDIR=${D} install || die
}
