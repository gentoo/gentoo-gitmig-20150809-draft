# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mindi/mindi-0.85.ebuild,v 1.1 2003/06/19 08:28:46 johnm Exp $

DESCRIPTION="Mindi builds boot/root disk images using your existing kernel, modules, tools and libraries"
HOMEPAGE="http://www.microwerks.net/~hugo/mindi/"
SRC_URI="http://www.microwerks.net/~hugo/download/stable/final/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=sys-apps/bzip2-1.0.1
		>=app-cdr/cdrtools-1.11
		>=sys-libs/ncurses-5
		>=sys-devel/binutils-2
		>=sys-apps/syslinux-1.7
		>=sys-apps/lilo-22
		>=app-admin/dosfstools-2.8"

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
	unpack ${A}
}


src_install() {
	dodir /usr/share/mindi
	dodir /usr/sbin
	cp * --parents -rdf ${D}/usr/share/mindi/
	dosym /usr/share/mindi/mindi /usr/sbin/
}
