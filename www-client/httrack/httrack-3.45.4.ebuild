# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/httrack/httrack-3.45.4.ebuild,v 1.2 2012/06/22 20:48:51 sping Exp $

EAPI="4"

AT_M4DIR='m4'
inherit autotools eutils

DESCRIPTION="HTTrack Website Copier, Open Source Offline Browser"
HOMEPAGE="http://www.httrack.com/"
SRC_URI="http://download.httrack.com/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="static-libs"

RDEPEND=">=sys-libs/zlib-1.2.5.1-r1"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS README greetings.txt history.txt )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.44.1+zlib-1.2.5.1.patch

	sed -i \
		"/^HelpHtml.*dir/s:${PN}:${PF}:" \
		"${S}"/html/Makefile.in || die

	# https://bugs.gentoo.org/show_bug.cgi?id=421499
	epatch "${FILESDIR}"/${P}-parallel.patch
	epatch "${FILESDIR}"/${P}-install-once.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static) \
		--docdir=/usr/share/doc/${PF} \
		--htmldir=/usr/share/doc/${PF}/html
}

src_install() {
	default
	rm -rf "${ED}"/usr/share/doc/"${PN}" || die
}
