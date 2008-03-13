# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mindi/mindi-2.0.0.ebuild,v 1.2 2008/03/13 11:10:22 wschlich Exp $

DESCRIPTION="A program that creates emergency boot disks/CDs using your kernel, tools and modules"
HOMEPAGE="http://www.mondorescue.org"
SRC_URI="ftp://ftp.mondorescue.org/src/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"
IUSE=""
DEPEND="virtual/libc"
RDEPEND=">=app-arch/bzip2-0.9
		sys-libs/ncurses
		sys-devel/binutils
		sys-fs/dosfstools
		sys-apps/mindi-busybox
		sys-apps/parted
		sys-apps/gawk"

src_install() {
	export HEAD="${D}"
	export PREFIX="/usr"
	export CONFDIR="/etc"
	export CACHEDIR="/var/cache/mindi"
	export MANDIR="${PREFIX}/share/man"
	export DOCDIR="${PREFIX}/share/doc"
	export LIBDIR="${PREFIX}/lib"
	export DONT_RELINK=1
	export PKGBUILDMINDI="true"
	"${WORKDIR}"/"${P}"/install.sh
}

pkg_postinst() {
	einfo "${P} was successfully installed."
	einfo "Please read the associated docs for help."
	einfo "Or visit the website @ ${HOMEPAGE}"
	echo
	ewarn "Please report bugs to http://bugs.gentoo.org/"
	ewarn "However, please do an advanced query to search for bugs"
	ewarn "before reporting. This will keep down on duplicates."
	echo
}
