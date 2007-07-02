# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mindi/mindi-0.86.ebuild,v 1.13 2007/07/02 03:04:52 peper Exp $

inherit eutils

DESCRIPTION="Mindi builds boot/root disk images using your existing kernel, modules, tools and libraries"
HOMEPAGE="http://www.microwerks.net/~hugo/mindi/"
SRC_URI="http://www.microwerks.net/~hugo/download/stable/final/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="userpriv"

DEPEND=">=app-arch/bzip2-1.0.1
		>=app-cdr/cdrtools-1.11
		>=sys-libs/ncurses-5
		>=sys-devel/binutils-2
		>=sys-boot/syslinux-1.7
		>=sys-boot/lilo-22
		>=sys-fs/dosfstools-2.8
		>=sys-apps/mindi-kernel-1"

src_unpack() {
	for i in ${FEATURES} ; do
		if [ "${i}" = "userpriv" ] ; then
			echo
			ewarn "mindi cannot be installed if userpriv"
			ewarn "is set within FEATURES."
			ewarn "Please emerge mindi as follows:"
			echo
			ewarn "# FEATURES=\"-userpriv\" emerge mindi"
			die "userpriv failure"
		fi
	done
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-security.patch
}

src_install() {
	dodir /usr/share/mindi /usr/sbin
	cp * --parents -rdf ${D}/usr/share/mindi/
	rm ${D}/usr/share/mindi/{CHANGES,INSTALL,LICENSE,README,TODO}
	dodoc CHANGES INSTALL LICENSE README TODO
	dosym /usr/share/mindi/mindi /usr/sbin/
}
