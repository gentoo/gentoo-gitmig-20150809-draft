# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sed/sed-4.0.9.ebuild,v 1.15 2004/08/05 18:40:55 j4rg0n Exp $

inherit gnuconfig

DESCRIPTION="Super-useful stream editor"
HOMEPAGE="http://www.gnu.org/software/sed/sed.html"
SRC_URI="mirror://gnu/sed/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~ppc64 sparc mips alpha arm hppa amd64 ia64 s390 macos"
IUSE="nls static build"

DEPEND="virtual/libc
	nls? ( sys-devel/gettext )"

src_compile() {
	# Needed for mips and probably others
	gnuconfig_update

	use macos && EXTRA_ECONF="--program-prefix=g"
	econf `use_enable nls` || die "Configure failed"
	if use static ; then
		emake LDFLAGS=-static || die "Static build failed"
	else
		emake || die "Shared build failed"
	fi
}

src_install() {
	into /
	dobin sed/sed
	if ! use build
	then
		einstall || die "Install failed"
		dodoc COPYING NEWS README* THANKS AUTHORS BUGS ChangeLog
		docinto examples
		dodoc ${FILESDIR}/dos2unix ${FILESDIR}/unix2dos
	else
		dodir /usr/bin
	fi

	rm -f ${D}/usr/bin/sed
	use macos && cd ${D} && for x in `find . -name 'sed*' -print`; do mv "$x" "${x//sed/gsed}"; done && cd ${WORKDIR}/${P}
	use macos && dosym ../../bin/gsed /usr/bin/gsed || dosym ../../bin/sed /usr/bin/sed
}
