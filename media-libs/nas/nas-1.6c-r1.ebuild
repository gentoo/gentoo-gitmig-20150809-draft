# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/nas/nas-1.6c-r1.ebuild,v 1.2 2004/03/26 21:14:32 eradicator Exp $

DESCRIPTION="Network Audio System"
SRC_URI="http://radscan.com/nas/${P}.src.tar.gz"
HOMEPAGE="http://radscan.com/nas.html"

SLOT="0"
LICENSE="X11"
KEYWORDS="~x86 ~sparc ~ppc ~hppa ~alpha ~amd64 ~ia64 ~mips"

IUSE=""

# This is ridculuous, we only need xmkmf, but no other package
# provides it. 20020607 (Seemant): Actually, the homepage says it needs
# the entire X11 build environment, so this is ok.
RDEPEND="virtual/x11"

DEPEND="${RDEPEND}
	sys-apps/sed"

src_compile() {
	xmkmf
	touch doc/man/lib/tmp.{_man,man}
	emake World || die
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
