# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/zile/zile-2.4.1.ebuild,v 1.3 2011/09/26 17:46:57 grobian Exp $

EAPI=4

DESCRIPTION="Zile is a small Emacs clone"
HOMEPAGE="http://www.gnu.org/software/zile/"
SRC_URI="mirror://gnu/zile/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="acl livecd test valgrind"

RDEPEND="dev-libs/boehm-gc
	sys-libs/ncurses
	acl? ( virtual/acl )"

DEPEND="${RDEPEND}
	test? ( valgrind? ( dev-util/valgrind ) )"

src_configure() {
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--disable-silent-rules \
		$(use_enable acl) \
		$(use test && use_with valgrind || echo --without-valgrind)
}

src_install() {
	emake DESTDIR="${D}" install

	# AUTHORS, FAQ, and NEWS are installed by the build system
	dodoc README THANKS

	# Zile should never install charset.alias (even on non-glibc arches)
	rm -f "${ED}"/usr/lib/charset.alias
}

pkg_postinst() {
	if use livecd; then
		[[ -e ${EROOT}/usr/bin/emacs ]] || ln -s zile "${EROOT}"/usr/bin/emacs
	fi
}
