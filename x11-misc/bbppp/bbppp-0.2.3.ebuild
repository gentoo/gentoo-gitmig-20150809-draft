# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbppp/bbppp-0.2.3.ebuild,v 1.6 2005/01/08 18:39:23 ka0ttic Exp $

inherit eutils

DESCRIPTION="blackbox ppp frontend/monitor"
HOMEPAGE="http://bbtools.windsofstorm.net/sources/available.phtml#bbppp"
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE=""

DEPEND="virtual/blackbox"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gcc3-multiline.diff
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc README COPYING AUTHORS BUGS INSTALL ChangeLog NEWS TODO data/README.bbppp
}

pkg_postinst() {
	# don't assume blackbox exists because virtual/blackbox is installed
	if [[ -x ${ROOT}/usr/bin/blackbox ]] ; then
		if ! grep bbppp ${ROOT}/usr/bin/blackbox &>/dev/null ; then
			sed -e "s/.*blackbox/exec \/usr\/bin\/bbppp \&\n&/" blackbox | cat > blackbox
		fi
	fi
}
