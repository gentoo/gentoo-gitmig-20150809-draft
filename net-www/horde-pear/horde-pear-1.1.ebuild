# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-pear/horde-pear-1.1.ebuild,v 1.6 2004/01/27 00:59:09 vapier Exp $

inherit horde

DESCRIPTION="Horde Application Framework PHP PEAR files"
HOMEPAGE="http://www.horde.org/"
SRC_URI="http://ftp.horde.org/pub/${HORDE_PN}/tarballs/${HORDE_PN}-${PV}.tar.bz2"

KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND=""
RDEPEND=">=dev-php/mod_php-4.1.0
	>=sys-devel/gettext-0.10.40
	>=dev-libs/libxml2-2.4.21-r1"

S=${WORKDIR}/pear

pkg_setup() { :;}

src_install() {
	dodir /usr/lib
	cp -a ${S} ${D}/usr/lib/php
}

pkg_postinst() { :;}
