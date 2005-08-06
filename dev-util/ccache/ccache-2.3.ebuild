# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ccache/ccache-2.3.ebuild,v 1.22 2005/08/06 21:07:53 gongloo Exp $

DESCRIPTION="fast compiler cache"
HOMEPAGE="http://ccache.samba.org/"
SRC_URI="http://ccache.samba.org/ftp/ccache/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ppc-macos"
IUSE=""

DEPEND="virtual/libc
	>=sys-apps/portage-2.0.46-r11"

# Note: this version is designed to be auto-detected and used if
# you happen to have Portage 2.0.X+ installed.

src_install() {
	dobin ccache || die
	doman ccache.1
	dodoc README
	dohtml web/*.html

	diropts -m0755
	dodir /usr/lib/ccache/bin
	keepdir /usr/lib/ccache/bin

	exeinto /usr/bin
	doexe ${FILESDIR}/ccache-config

	diropts -m0700
	if use ppc-macos; then
		dodir /var/root/.ccache
		keepdir /var/root/.ccache
	else
		dodir /root/.ccache
		keepdir /root/.ccache
	fi
}

pkg_preinst() {
	# Portage doesn't handle replacing a non-empty dir with a file!
	[[ -e ${ROOT}/usr/bin/ccache ]] && rm -r "${ROOT}"/usr/bin/ccache
	[[ -e ${ROOT}/usr/bin/ccache.backup ]] && rm -r "${ROOT}"/usr/bin/ccache.backup
}

pkg_postinst() {
	if [[ ${ROOT} = "/" ]] ; then
		einfo "Scanning for compiler front-ends..."
		/usr/bin/ccache-config --install-links
		/usr/bin/ccache-config --install-links ${CHOST}
	else
		ewarn "Install is incomplete; you must run the following commands:"
		ewarn " # ccache-config --install-links"
		ewarn " # ccache-config --install-links ${CHOST}"
		ewarn "after booting or chrooting to ${ROOT} to complete installation."
	fi

	einfo "To use ccache with **non-Portage** C compiling, add"
	einfo "/usr/lib/ccache/bin to the beginning of your path, before /usr/bin."
	einfo "Portage 2.0.46-r11+ will automatically take advantage of ccache with"
	einfo "no additional steps.  If this is your first install of ccache, type"
	einfo "something like this to set a maximum cache size of 2GB:"
	einfo "# ccache -M 2G"
}
