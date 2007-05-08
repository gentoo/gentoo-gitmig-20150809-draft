# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gnulib/gnulib-9999.ebuild,v 1.1 2007/05/08 16:14:50 drizzt Exp $

ECVS_SERVER="cvs.savannah.gnu.org:/cvsroot/gnulib"
ECVS_MODULE="gnulib"

inherit eutils cvs

DESCRIPTION="Gnulib is a library of common routines intended to be shared at the source level."
HOMEPAGE="http://www.gnu.org/software/gnulib"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${PN}

src_compile() {
	emake -C doc info html || die "emake failed"
}

src_install() {
	dodoc README COPYING ChangeLog
	dohtml doc/gnulib.html
	doinfo doc/gnulib.info

	insinto /usr/share/${PN}
	doins -r lib
	doins -r m4
	doins -r modules

	# remove CVS dirs
	find "${D}" -name CVS -type d -print0 | xargs -0 rm -r

	# install the real script
	exeinto /usr/share/${PN}
	doexe gnulib-tool

	# create and install the wrapper
	make_wrapper gnulib-tool ./gnulib-tool /usr/share/${PN}
}
