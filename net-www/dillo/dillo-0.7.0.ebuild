# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/dillo/dillo-0.7.0.ebuild,v 1.1 2003/02/18 08:59:27 seemant Exp $

inherit flag-o-matic

IUSE="ipv6 kde gnome mozilla"

S=${WORKDIR}/${P}
S2=${WORKDIR}/gentoo-dillo-extras-patch

DESCRIPTION="Lean GTK+-based web browser"
HOMEPAGE="http://dillo.auriga.wearlab.de/"
SRC_URI="http://dillo.auriga.wearlab.de/download/${P}.tar.gz"
#	mirror://gentoo/gentoo-dillo-extras-patch.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa"

replace-flags "-O2 -mcpu=k6" "-O2 -mcpu=pentium"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.3
	>=media-libs/libpng-1.2.1"

#
# The custom icons seem to break compilation, so we'll need to wait
# for a new release

#src_unpack() {
#	unpack ${A}
#	cd ${S}
#	
#	if use kde
#	then
#		cp ${S2}/pixmaps.konq.h ${S}/src/pixmaps.h
#	elif use gnome
#	then
#		cp ${S2}/pixmaps.ximian.h ${S}/src/pixmaps.h
#	elif use mozilla
#	then
#		cp ${S2}/pixmaps.netscape.h ${S}/src/pixmaps.h
#	fi
#}

src_compile() {
	econf `use_enable ipv6` || die
	emake || make || die
}

src_install() {
	dodir /etc
	einstall
	dodoc AUTHORS COPYING ChangeLog* INSTALL README NEWS
	docinto doc
	dodoc doc/*.txt doc/README
}

#pkg_postinst() {
#	einfo "This ebuild for dillo comes with different toolbar icons"
#	einfo "If you want mozilla style icons then try"
#	einfo "	USE=\"-kde -gnome mozilla\" emerge dillo"
#	einfo
#	einfo "If you prefer konqueror style icons then try"
#	einfo "	USE=\"-mozilla -gnome kde\" emerge dillo"
#	einfo
#	einfo "If you prefer ximian gnome style icons then try"
#	einfo "	USE=\"-mozilla -kde gnome\" emerge dillo"
#	einfo
#	einfo "Otherwise, if you want the default icon set, then do"
#	einfo "	USE=\"-mozilla -kde -gnome\" emerge dillo"
#	einfo
#	einfo "Do not worry, no extra dependencies will be pulled in"
#}
