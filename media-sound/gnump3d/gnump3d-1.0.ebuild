# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnump3d/gnump3d-1.0.ebuild,v 1.6 2003/03/11 21:11:46 seemant Exp $

inherit eutils

DESCRIPTION="A streaming server for MP3, OGG vorbis and other streamable files"
SRC_URI="mirror://sourceforge/gnump3d/${P}.tar.gz"
HOMEPAGE="http://gnump3d.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="oggvorbis"

DEPEND="virtual/glibc"
RDEPEND=">=dev-lang/perl-5.6.1
	oggvorbis? ( media-libs/libvorbis )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff.bz2
}

src_compile() {
	econf `use_with oggvorbis vorbis` || die
	emake || die
}

src_install() {
	make \
		PREFIX=${D}/usr \
		CONFIGDIR=${D}/etc/${PN} \
		MANDIR=${D}/usr/share/man/man1 \
		DESTDIR=${D} \
		install || die
	dodoc AUTHORS BUGS ChangeLog COPYING README*
	exeinto /etc/init.d
	newexe ${FILESDIR}/gnump3d-1.0.rc6 gnump3d
	# gnump3d specific libraries should NOT be sitting
	# in /usr/lib.
	dodir /usr/lib/gnump3d
	mv ${D}/usr/lib/* ${D}/usr/lib/gnump3d
	# This is for Debian's configuration system
	rm ${D}/usr/bin/gnump3d-config
	dodir /var/log/gnump3d
}

pkg_postinst() {
	einfo
	einfo "The default directory for shared mp3s is /home/mp3"
	einfo "Please edit your /etc/gnump3d/gnump3d.conf before"
	einfo "running /etc/init.d/gnump3d start"
	einfo
}
