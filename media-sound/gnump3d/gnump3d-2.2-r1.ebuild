# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnump3d/gnump3d-2.2-r1.ebuild,v 1.1 2003/05/10 06:09:42 jje Exp $

DESCRIPTION="A streaming server for MP3, OGG vorbis and other streamable files"
SRC_URI="mirror://sourceforge/gnump3d/${P}.tar.gz"
HOMEPAGE="http://gnump3d.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=">=dev-lang/perl-5.8.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_install() {
	make \
		LIBDIR=${D}`perl bin/getlibdir` \
		PREFIX=${D}/usr \
		install || die

	# init.d
	exeinto /etc/init.d
	newexe ${FILESDIR}/gnump3d-2.2-initd gnump3d

	# just to be sure..
	dosym usr/bin/gnump3d2 gnump3d

	# make directories
	DIROPTIONS="--owner=nobody" dodir /var/log/gnump3d
	dodir /etc/gnump3d

	# copy config files
	insinto /etc/gnump3d	
	doins etc/*
	
	# docs
	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
}

pkg_postinst() {
	einfo
	einfo "The default directory for shared mp3s is /home/mp3"
	einfo "Please edit your /etc/gnump3d/gnump3d.conf before"
	einfo "running /etc/init.d/gnump3d start"
	einfo
}

