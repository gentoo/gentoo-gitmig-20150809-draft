# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/smbc/smbc-1.2.2-r2.ebuild,v 1.2 2012/02/29 04:39:48 jer Exp $

EAPI="2"

inherit autotools

DESCRIPTION="A text mode (ncurses) SMB network commander. Features: resume and UTF-8"
HOMEPAGE="http://sourceforge.net/projects/smbc/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~hppa ~ppc ~x86"
IUSE="nls debug"

DEPEND="net-fs/samba
	sys-libs/ncurses
	dev-libs/popt
	nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-cflags.patch
	epatch "${FILESDIR}"/${P}-size_t.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with debug) \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	mkdir -p "${D}/usr/share/doc"
	mv -v "${D}/usr/share/"{${PN},doc/${PF}}
}
