# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdemu/cdemu-0.7.ebuild,v 1.1 2004/11/22 13:58:17 vapier Exp $

inherit gcc flag-o-matic python

DESCRIPTION="mount bin/cue cd images"
HOMEPAGE="http://cdemu.org/"
SRC_URI="mirror://sourceforge/cdemu/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="hppa ppc x86"
IUSE=""

DEPEND="virtual/linux-sources"
RDEPEND="dev-lang/python"

src_compile() {
	if [ "${KV:0:3}" == "2.6" ] && [[ `KV_to_int ${KV}` -lt `KV_to_int 2.6.6` ]] ; then
		emake KERN_DIR=/usr/src/linux BUILD_GHETTO=yes || die
	else
		env -u ARCH emake KERN_DIR=/usr/src/linux || die
	fi
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog README TODO
}

pkg_postinst() {
	[ "${ROOT}" == "/" ] && depmod -a
}
