# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/xvid/xvid-0.9.2-r1.ebuild,v 1.3 2004/01/29 04:17:36 agriffis Exp $

MY_P=${PN}core-${PV}
S="${WORKDIR}/${MY_P}/build/generic"
DESCRIPTION="XviD, a high performance/quality MPEG-4 video de-/encoding solution."
SRC_URI="http://files.xvid.org/downloads/${MY_P}.tar.bz2"
HOMEPAGE="http://www.xvid.org/"

DEPEND="virtual/glibc
	x86? ( >=dev-lang/nasm-0.98.36 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"

src_compile() {
	[ -z "${CC}" ] && export CC="gcc"

	econf || die
	emake || die
}

src_install() {
	dodir /usr/{include,lib}
	einstall || die

	cd ${S}/../../

	dodoc authors.txt changelog.txt LICENSE README.txt todo.txt
	dosym /usr/lib/libxvidcore.so.2.1 /usr/lib/libxvidcore.so

	if [ "`use doc`" ]
	then
		dodoc CodingStyle doc/README doc/xvid-decoding.txt doc/xvid-encoder.txt

		dodoc doc/xvid-api-ref.pdf
		dohtml -r doc/xvid-api-ref

		insinto /usr/share/doc/${PF}/examples
		doins examples/*
		# Empty for this release ...
		#insinto /usr/share/doc/${PF}/examples/ex1
		#doins examples/ex1/*
	fi
}
