# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/media-video/yanc/yanc-0.2.0.ebuild,v 1.1 2003/06/15 05:58:25 seemant Exp $


S=${WORKDIR}/${P}
DESCRIPTION="YanC is a GUI configuration tool for the NVIDIA Accelerated Linux Driver Set."
HOMEPAGE="http://yanc.sourceforge.net/"
SRC_URI="mirror://sourceforge/yanc/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~x86"

#
# As the downloaded package seems to be pre-compiled,
# the dependances are not clear.
# TODO: Emerge the real compilable yanc's code
#
DEPEND=">=sys-apps/sed-4"
RDEPEND="x11-base/xfree"


src_compile() {
	einfo "nothing to compile"
}

src_install () {
	dodir /usr/share/yanc
	dodir /usr/lib
	dodir /usr/bin

	cp -r src ${D}/usr/share/yanc
	cp -r lang ${D}/usr/share/yanc
	dolib lib/libborqt-6.9.0-qt2.3.so
	dosym libborqt-6.9.0-qt2.3.so /usr/lib/libborqt-6.9-qt2.3.so

	insinto /usr/share/yanc
	doins logo.jpg gpl.jpg loeschen.xpm nachunten.xpm nachoben.xpm yanc.xpm
	doins LICENSE

	exeinto /usr/share/yanc
	doexe yanc

	
	into /usr
	dobin script/yanc
	dosed "s:local:share:" /usr/bin/yanc

	dodoc README*
	dohtml doc
}

pkg_postinst() {
	einfo ''
	einfo 'WARNING:'
	einfo '========'
	einfo '-> Please create a copy of your XF86Config before you use YanC for the'
	einfo 'first time, because it is possible that your XF86Config is damaged because of'
	einfo 'the use of YanC. Then a restart of XFree would be impossible.'
	einfo ''
	echo  ''
}
