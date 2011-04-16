# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbtime/bbtime-0.1.5.ebuild,v 1.10 2011/04/16 17:48:29 ulm Exp $

EAPI=2

inherit autotools eutils

DESCRIPTION="blackbox time watcher"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbtime"
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README AUTHORS BUGS ChangeLog NEWS TODO data/README.bbtime || die

	rm "${D}"/usr/share/bbtools/README.bbtime
	# since multiple bbtools packages provide this file, install
	# it in /usr/share/doc/${PF}
	mv "${D}/usr/share/bbtools/bbtoolsrc.in" \
		"${D}/usr/share/doc/${PF}/bbtoolsrc.example"
}
