# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/antiword/antiword-0.37.ebuild,v 1.15 2011/08/08 20:07:39 grobian Exp $

EAPI="3"

inherit eutils toolchain-funcs

IUSE="kde"
PATCHVER=0.1
DESCRIPTION="free MS Word reader"
HOMEPAGE="http://www.winfield.demon.nl"
SRC_URI="http://www.winfield.demon.nl/linux/${P}.tar.gz
	mirror://gentoo/${P}-gentoo-${PATCHVER}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ppc ppc64 sparc x86 ~ppc-aix ~ia64-hpux ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"

PATCHDIR=${WORKDIR}/gentoo-antiword/patches

src_prepare() {
	EPATCH_SUFFIX="diff" \
		epatch ${PATCHDIR}

	epatch "${FILESDIR}"/${P}-prefix.patch
}

src_configure() { :; }

src_compile() {
	emake PREFIX="${EPREFIX}" OPT="${CFLAGS}" CC="$(tc-getCC)" LD="$(tc-getCC)" \
		LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	emake -j1 PREFIX="${EPREFIX}" DESTDIR="${D}" global_install || die

	use kde || rm -f "${ED}"/usr/bin/kantiword

	insinto /usr/share/${PN}/examples
	doins Docs/testdoc.doc Docs/antiword.php || die

	cd Docs
	doman antiword.1 || die
	dodoc ChangeLog Exmh Emacs FAQ History Netscape QandA ReadMe Mozilla Mutt || die
}
