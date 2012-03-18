# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbppp/bbppp-0.2.3.ebuild,v 1.10 2012/03/18 15:44:48 armin76 Exp $

inherit autotools eutils

DESCRIPTION="blackbox ppp frontend/monitor"
HOMEPAGE="http://bbtools.windsofstorm.net/sources/available.phtml#bbppp"
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="x11-libs/libX11"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-gcc3-multiline.diff \
		"${FILESDIR}"/${PN}-asneeded.patch
	eautoreconf
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc README AUTHORS BUGS ChangeLog NEWS TODO data/README.bbppp || die
	rm "${D}"/usr/share/bbtools/README.bbppp
}

pkg_postinst() {
	# don't assume blackbox exists because virtual/blackbox is installed
	if [[ -x ${ROOT}/usr/bin/blackbox ]] ; then
		if ! grep bbppp "${ROOT}"/usr/bin/blackbox &>/dev/null ; then
			sed -e "s/.*blackbox/exec \/usr\/bin\/bbppp \&\n&/" blackbox | cat > blackbox
		fi
	fi
}
