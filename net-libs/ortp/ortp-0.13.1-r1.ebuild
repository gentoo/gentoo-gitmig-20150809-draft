# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/ortp/ortp-0.13.1-r1.ebuild,v 1.6 2009/05/02 13:26:05 jer Exp $

EAPI="2"

DESCRIPTION="Open Real-time Transport Protocol (RTP, RFC3550) stack"
HOMEPAGE="http://www.linphone.org/index.php/eng/code_review/ortp/"
SRC_URI="http://download.savannah.nongnu.org/releases/linphone/${PN}/sources/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="debug doc examples ipv6"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_prepare() {
	# to be sure doc is not compiled nor installed with -doc and doxygen inst
	if ! use doc; then
		sed -i -e 's/test $DOXYGEN != //' configure \
			|| die "patching configure failed"
	fi

	# do not build examples programs, see bug 226247
	sed -i -e 's/SUBDIRS = . tests/SUBDIRS = ./' src/Makefile.in \
		|| die "patching src/Makefile.in failed"
}

src_configure() {
	# memcheck is for HP-UX only
	# mode64bit adds +DA2.0W +DS2.0 CFLAGS wich are needed for HP-UX
	# strict adds -Werror, don't want it
	econf \
		$(use_enable debug) \
		$(use_enable ipv6) \
		--disable-memcheck \
		--disable-mode64bit \
		--disable-strict \
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins src/tests/*.c || die "doins failed"
	fi
}
