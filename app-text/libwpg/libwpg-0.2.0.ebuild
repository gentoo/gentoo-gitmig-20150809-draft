# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libwpg/libwpg-0.2.0.ebuild,v 1.1 2011/08/04 16:25:30 scarabeus Exp $

EAPI="4"

inherit alternatives autotools

DESCRIPTION="C++ library to read and parse graphics in WPG"
HOMEPAGE="http://libwpg.sourceforge.net/libwpg.htm"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0.2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc"

RDEPEND="app-text/libwpd:0.9[tools]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"
RDEPEND="${RDEPEND}
	!<app-text/libwpd-0.1.3-r1"

src_prepare() {
	sed -i -e 's: -Werror::g' configure.in || die
	# FIXME: Touching configure.in triggers maintainer-mode always
	eautoreconf
}

src_configure() {
	econf \
		--program-suffix=-${SLOT} \
		--disable-dependency-tracking \
		$(use_with doc docs)
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete
}

pkg_postinst() {
	alternatives_auto_makesym /usr/bin/wpg2svgbatch.pl "/usr/bin/wpg2svgbatch.pl-[0-9].[0-9]"
	alternatives_auto_makesym /usr/bin/wpg2svg "/usr/bin/wpg2svg-[0-9].[0-9]"
	alternatives_auto_makesym /usr/bin/wpg2raw "/usr/bin/wpg2raw-[0-9].[0-9]"	fi
}

pkg_postrm() {
	alternatives_auto_makesym /usr/bin/wpg2svgbatch.pl "/usr/bin/wpg2svgbatch.pl-[0-9].[0-9]"
	alternatives_auto_makesym /usr/bin/wpg2svg "/usr/bin/wpg2svg-[0-9].[0-9]"
	alternatives_auto_makesym /usr/bin/wpg2raw "/usr/bin/wpg2raw-[0-9].[0-9]"
}
