# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdialog/xdialog-2.3.1.ebuild,v 1.6 2009/02/15 13:48:42 ranger Exp $

inherit eutils autotools

DESCRIPTION="drop-in replacement for cdialog using GTK"
HOMEPAGE="http://xdialog.dyns.net/"
SRC_URI="http://thgodef.nerim.net/xdialog/Xdialog-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ppc x86"
IUSE="doc examples nls"

RDEPEND=">=x11-libs/gtk+-2.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${P/x/X}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-no-strip.patch"
	eautoreconf
}

src_compile() {
	econf $(use_enable nls) --with-gtk2
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	rm -rf "${D}"/usr/share/doc

	dodoc AUTHORS BUGS ChangeLog README

	use doc && dohtml -r doc/

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins samples/*
	fi
}
