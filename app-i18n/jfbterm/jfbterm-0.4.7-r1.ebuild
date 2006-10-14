# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/jfbterm/jfbterm-0.4.7-r1.ebuild,v 1.6 2006/10/14 09:31:33 flameeyes Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit flag-o-matic eutils autotools

DESCRIPTION="The J Framebuffer Terminal/Multilingual Enhancement with UTF-8 support"
HOMEPAGE="http://jfbterm.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/13501/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="ppc ppc64 sparc x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-sigchld-debian.patch"

	eautoreconf
}

src_compile() {
	econf || die "econf failed"
	# jfbterm peculiarly needs to be compiled twice.
	emake -j1 || die "make failed"
	emake -j1 || die "make failed"
	sed -i -e 's/a18/8x16/' jfbterm.conf.sample
}

src_install() {
	dodir /etc /usr/share/fonts/jfbterm
	make DESTDIR="${D}" install || die

	dodir /usr/share/terminfo
	tic terminfo.jfbterm -o"${D}"/usr/share/terminfo || die

	mv "${D}"/etc/jfbterm.conf{.sample,}

	doman jfbterm.1 jfbterm.conf.5

	dodoc AUTHORS ChangeLog INSTALL* NEWS README*
	dodoc jfbterm.conf.sample*
}
