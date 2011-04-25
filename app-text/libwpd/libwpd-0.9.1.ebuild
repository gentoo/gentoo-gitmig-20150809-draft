# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libwpd/libwpd-0.9.1.ebuild,v 1.3 2011/04/25 13:44:18 pacho Exp $

EAPI="4"

inherit alternatives autotools eutils

DESCRIPTION="WordPerfect Document import/export library"
HOMEPAGE="http://libwpd.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0.9"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="doc test +tools"

RDEPEND="dev-libs/glib:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )
	test? ( dev-util/cppunit )
"
RDEPEND="${RDEPEND}
	!<app-text/libwpd-0.8.14-r1"

src_prepare() {
	# Do not abort build for warnings
	sed -i -e 's:-Werror::g' configure.in configure || die

	# Do not build tests if not needed (and no before the lib itself)
	epatch "${FILESDIR}/${P}-test-build.patch"
	eautoreconf
}

src_configure() {
	econf \
		$(use_with doc docs) \
		$(use_with tools stream) \
		--program-suffix=-${SLOT}
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete
}

pkg_postinst() {
	if use tools; then
		alternatives_auto_makesym /usr/bin/wpd2html "/usr/bin/wpd2html-[0-9].[0-9]"
		alternatives_auto_makesym /usr/bin/wpd2raw "/usr/bin/wpd2raw-[0-9].[0-9]"
		alternatives_auto_makesym /usr/bin/wpd2text "/usr/bin/wpd2text-[0-9].[0-9]"
	fi
}

pkg_postrm() {
	if use tools; then
		alternatives_auto_makesym /usr/bin/wpd2html "/usr/bin/wpd2html-[0-9].[0-9]"
		alternatives_auto_makesym /usr/bin/wpd2raw "/usr/bin/wpd2raw-[0-9].[0-9]"
		alternatives_auto_makesym /usr/bin/wpd2text "/usr/bin/wpd2text-[0-9].[0-9]"
	fi
}
