# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnump3d/gnump3d-2.2.ebuild,v 1.3 2003/04/18 18:27:53 malverian Exp $

inherit eutils

DESCRIPTION="A streaming server for MP3, OGG vorbis and other streamable files"
SRC_URI="mirror://sourceforge/gnump3d/${P}.tar.gz"
HOMEPAGE="http://gnump3d.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND=">=dev-lang/perl-5.6.1"

src_install() {
	eval `perl '-V:installarchlib'`
        ARCH_LIB=${installarchlib}

	insinto ${ARCH_LIB}/gnump3d
	doins lib/gnump3d/*.pm

	insinto ${ARCH_LIB}/gnump3d/plugins
	doins lib/gnump3d/plugins/*.pm

	into /usr

	dobin bin/gnump3d2 bin/gnump3d-top
	dosym /usr/bin/gnump3d2 /usr/bin/gnump3d

	doman man/*.1

	for a in templates/*; do
		insinto /usr/share/gnump3d/${a/templates}
		doins templates/${a/templates}/*
	done

	exeinto /etc/init.d
	newexe ${FILESDIR}/gnump3d-${PV}.rc6 gnump3d

	insinto /etc/gnump3d
	doins etc/gnump3d.conf etc/mime.types

	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
}

