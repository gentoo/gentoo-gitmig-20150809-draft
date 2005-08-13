# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/nas/nas-1.7-r1.ebuild,v 1.7 2005/08/13 13:20:40 chainsaw Exp $

IUSE="static"

inherit eutils

DESCRIPTION="Network Audio System"
HOMEPAGE="http://radscan.com/nas.html"
SRC_URI="http://radscan.com/nas/${P}.src.tar.gz"

SLOT="0"
LICENSE="X11"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ppc64 sparc x86"

RDEPEND="virtual/x11"

DEPEND="${RDEPEND}
	sys-apps/sed"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-header.patch
	epatch ${FILESDIR}/${P}-gcc4.patch
}

src_compile() {
	xmkmf
	touch doc/man/lib/tmp.{_man,man}
	CFLAGS="-O2 -ggdb" emake World || die
}

src_install () {
	make DESTDIR=${D} install || die
	make DESTDIR=${D} install.man || die

	for i in ${D}/usr/X11R6/man/man?/*.?x
	do
		gzip -9 $i
	done

	dodoc BUGS BUILDNOTES FAQ HISTORY README RELEASE TODO
	mv ${D}/usr/X11R6/lib/X11/doc/html ${D}/usr/share/doc/${P}/
	rmdir ${D}/usr/X11R6/lib/X11/doc

	# rename example nasd.conf.eg to nasd.conf and change it so that NAS
	# doesn't change mixer's settings (inspired by Debian package):
	mv ${D}/etc/nas/nasd.conf.eg ${D}/etc/nas/nasd.conf
	dosed 's,\(MixerInit.*\)"\(.*\)",\1"no",' /etc/nas/nasd.conf

	# Remove the static lib
	use static || rm ${D}/usr/X11R6/lib/libaudio.a

	insinto /etc/conf.d
	newins ${FILESDIR}/nas.conf.d nas
	exeinto /etc/init.d
	newexe ${FILESDIR}/nas.init.d nas
}

pkg_postinst() {
	einfo "To enable NAS on boot you will have to add it to the"
	einfo "default profile, issue the following command as root to do so."
	einfo ""
	einfo "rc-update add nas default"
}
