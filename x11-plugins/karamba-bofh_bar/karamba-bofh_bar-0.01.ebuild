# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-bofh_bar/karamba-bofh_bar-0.01.ebuild,v 1.2 2003/05/04 03:21:35 prez Exp $

DESCRIPTION="BOFH bar plugin for Karamba"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=5892"
SRC_URI="http://www.kdelook.org/content/files/5892-bofh_bar.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="||( >=x11-misc/karamba-0.17 >=x11-misc/superkaramba-0.21 )"

src_unpack () {
	unpack ${A}
	mv home/lynrd/bofhbar/bofh_bar ${P}
	rm -rf home
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/bin /usr/share/karamba/themes/bofh_bar
	sed -e 's#~/bofh_bar/excuses#/usr/share/karamba/themes/bofh_bar/excuses#' \
		bofhserver.pl > ${D}/usr/share/karamba/bin/bofhserver.pl
	chmod 755 ${D}/usr/share/karamba/bin/bofhserver.pl
	sed -e 's#~/mails.pl#~/.karamba/mails.pl#' \
		-e 's#~/bofhserver.pl#bofhserver.pl#' \
		-e 's#/usr/bin/evolution#kmail#' \
		bofhbar.theme > ${D}/usr/share/karamba/themes/bofh_bar/bofh_bar.theme
	cp excuses ${D}/usr/share/karamba/themes/bofh_bar
	cp -r pics ${D}/usr/share/karamba/themes/bofh_bar
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/bofh_bar

	dodoc README COPYING COPYRIGHT mails.pl wishlist
}
