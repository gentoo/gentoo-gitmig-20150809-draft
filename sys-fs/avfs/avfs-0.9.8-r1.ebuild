# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/avfs/avfs-0.9.8-r1.ebuild,v 1.4 2010/10/10 10:56:07 hwoarang Exp $

inherit eutils linux-info

DESCRIPTION="AVFS is a virtual filesystem that allows browsing of compressed files."
HOMEPAGE="http://sourceforge.net/projects/avf"
SRC_URI="mirror://sourceforge/avf/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~ia64 ~ppc ~sparc x86"

DEPEND=">=sys-fs/fuse-2.4"
RDEPEND="${DEPEND}"

IUSE=""

pkg_setup() {
	kernel_is lt 2 6 && die "Must have a version 2.6 kernel. Cannot continue. :("
}

src_compile() {
	# Fixs bug #258295
	epatch "${FILESDIR}/${P}-gcc43_fix_open_missing_mode.patch"
	econf --enable-fuse --enable-library || die "Sorry, can't configure :("
	emake || die "Sorry make failed :("
}

src_install() {
	einstall || die "Sorry, make install failed :("
	# remove cruft
	dobin scripts/avfs-config
	cd "${D}"/usr
	rm -f bin/davpass bin/ftppass
	rm -fr sbin ../etc
	cd "${S}"
	cd doc
	dodoc api-overview background FORMAT INSTALL.* README.avfs-fuse
	cd ..
	dodoc AUTHORS ChangeLog COPYING* INSTALL NEWS README TODO
	docinto scripts
	dodoc scripts/avfs* scripts/*pass scripts/*mountavfs
	dosym /usr/lib/avfs/extfs/README /usr/share/doc/${PF}/README.extfs
}

pkg_postinst() {
	einfo "This version of AVFS includes FUSE support. It is user-based."
	einfo "To execute:"
	einfo "1) as user, mkdir ~/.avfs"
	einfo "2) make sure fuse is either compiled into the kernel OR"
	einfo "   modprobe fuse or add to startup."
	einfo "3) run mountavfs"
	einfo "To unload daemon, type umountavfs"
	echo
	einfo "READ the documentation! Enjoy :)"
}
