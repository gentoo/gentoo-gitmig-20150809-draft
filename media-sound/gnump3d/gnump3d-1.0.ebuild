# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnump3d/gnump3d-1.0.ebuild,v 1.1 2002/12/19 00:51:18 raker Exp $

IUSE="oggvorbis"

S=${WORKDIR}/${P}

DESCRIPTION="A streaming server for MP3, OGG vorbis and other streamable files"
SRC_URI="mirror://sourceforge/gnump3d/${P}.tar.gz"
HOMEPAGE="http://gnump3d.sourceforge.net/"

DEPEND="virtual/glibc"
RDEPEND=">=sys-devel/perl-5.6.1
	oggvorbis? ( media-libs/libvorbis )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {

	use oggvorbis && myconf="${myconf} --with-vorbis" \
		|| myconf="${myconf} --without-vorbis"

	econf ${myconf} || die
	emake || die

}

src_install() {
	dodir /usr/share/${PN}
	make PREFIX=${D}/usr \
		CONFIGDIR=${D}/etc/${PN} \
		TEMPLATEDIR=${D}/usr/share/${PN} \
		MANDIR=${D}/usr/share/man/man1 \
		DESTDIR=${D} install || die

	dodoc AUTHORS BUGS ChangeLog COPYING README*

	exeinto /etc/init.d
	newexe ${FILESDIR}/gnump3d.rc6 gnump3d
}
