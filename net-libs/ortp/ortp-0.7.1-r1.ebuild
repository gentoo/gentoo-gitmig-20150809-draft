# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/ortp/ortp-0.7.1-r1.ebuild,v 1.19 2009/04/15 02:22:43 volkmar Exp $

EAPI="2"

DESCRIPTION="Open Real-time Transport Protocol (RTP) stack"
HOMEPAGE="http://www.linphone.org/index.php/v2/code_review/ortp/"
SRC_URI="http://www.linphone.org/ortp/sources/${P}.tar.gz"

IUSE="examples ipv6"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"

DEPEND="=dev-libs/glib-2*
		>=dev-util/pkgconfig-0.9.0"
RDEPEND="=dev-libs/glib-2*"

src_prepare() {
	# do not build examples programs, see bug 226247
	sed -i -e 's/SUBDIRS = . tests/SUBDIRS = ./' src/Makefile.in \
		|| die "patching src/Makefile.in failed"
}

src_configure() {
	econf $(use_enable ipv6)
}

src_install() {
	emake DESTDIR="${D}" install || die "Make install failed"
	sed -i -e "s:^\(#include <\)\(glib\.h>\)$:\1glib-2.0/\2:" \
		"${D}"/usr/include/ortp/rtpport.h || die "patching rtpport.h failed"

	dodoc README ChangeLog AUTHORS TODO NEWS || die "dodoc failed"
	dodoc docs/*.txt || die "dodoc failed"

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins src/tests/*.c || die "doins failed"
	fi
}
