# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/avfs/avfs-0.9.7-r1.ebuild,v 1.5 2010/11/14 13:37:29 jlec Exp $

inherit linux-info

DESCRIPTION="AVFS is a virtual filesystem that allows browsing of compressed files."
HOMEPAGE="http://sourceforge.net/projects/avf"
SRC_URI="mirror://sourceforge/avf/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc sparc ~x86"
IUSE=""

DEPEND=">=sys-fs/fuse-2.4"
RDEPEND="${DEPEND}"

pkg_setup() {
	kernel_is lt 2 6 && die "Must have a version 2.6 kernel. Cannot continue. :("
}

src_compile() {
	econf --enable-fuse --enable-library
	emake || die "Sorry make failed :("
}

src_install() {
	einstall || die "Sorry, make install failed :("
	# remove cruft
	dobin scripts/avfs-config || die
	cd "${D}"/usr
	rm -f bin/davpass bin/ftppass || die
	rm -fr sbin ../etc || die
	cd "${S}"/doc
	dodoc api-overview background FORMAT INSTALL.* README.avfs-fuse || die
	cd ..
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO || die
	docinto scripts
	dodoc scripts/avfs* scripts/*pass scripts/*mountavfs || die
	dosym /usr/lib/avfs/extfs/README /usr/share/doc/${PF}/README.extfs || die
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
