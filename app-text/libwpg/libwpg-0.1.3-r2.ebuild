# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libwpg/libwpg-0.1.3-r2.ebuild,v 1.4 2011/10/18 14:29:28 jer Exp $

EAPI="4"

inherit alternatives

DESCRIPTION="C++ library to read and parse graphics in WPG"
HOMEPAGE="http://libwpg.sourceforge.net/libwpg.htm"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0.1"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc tools"

RDEPEND="app-text/libwpd:0.8[tools?]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_configure() {
	econf \
		--program-suffix=-${SLOT} \
		--disable-dependency-tracking \
		--docdir="${EPREFIX%/}/usr/share/doc/${PF}" \
		$(use_with doc docs) \
		$(use_with tools stream)
}

src_install() {
	default
	# Uses a binary that is conditionaly distributed
	use tools || rm "${ED}"/usr/bin/wpg2svgbatch.pl-${SLOT}
	find "${ED}" -name '*.la' -delete
}

pkg_postinst() {
	if use tools; then
		alternatives_auto_makesym /usr/bin/wpg2svgbatch.pl "/usr/bin/wpg2svgbatch.pl-[0-9].[0-9]"
		alternatives_auto_makesym /usr/bin/wpg2svg "/usr/bin/wpg2svg-[0-9].[0-9]"
		alternatives_auto_makesym /usr/bin/wpg2raw "/usr/bin/wpg2raw-[0-9].[0-9]"
	fi
}

pkg_postrm() {
	if use tools; then
		alternatives_auto_makesym /usr/bin/wpg2svgbatch.pl "/usr/bin/wpg2svgbatch.pl-[0-9].[0-9]"
		alternatives_auto_makesym /usr/bin/wpg2svg "/usr/bin/wpg2svg-[0-9].[0-9]"
		alternatives_auto_makesym /usr/bin/wpg2raw "/usr/bin/wpg2raw-[0-9].[0-9]"
	fi
}
