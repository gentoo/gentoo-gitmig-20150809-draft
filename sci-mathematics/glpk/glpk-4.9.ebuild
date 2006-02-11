# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/glpk/glpk-4.9.ebuild,v 1.1 2006/02/11 08:54:56 robbat2 Exp $

DESCRIPTION="GNU Linear Programming Kit"
LICENSE="GPL-2"
HOMEPAGE="http://www.gnu.org/software/glpk/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

SLOT="0"
IUSE="doc"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND=">=sys-devel/gcc-3.2
		virtual/libc
		doc? ( virtual/ghostscript )"
RDEPEND="virtual/libc"

src_compile() {
	LIBS="${LIBS} -lm" econf --enable-shared || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# INSTALL include some usage docs
	dodoc AUTHORS ChangeLog INSTALL NEWS README || \
		die "failed to install docs"

	# 250Kb
	insinto /usr/share/doc/${PF}/examples
	doins examples/*.mod && doins examples/*.tsp || \
		die "failed to install examples"

	# manual/ is 2.5Mb in size
	if use doc; then
		cd "${S}"/doc
		for i in *.ps; do
			ps2pdf14 "${i}" || die "failed to convert ps to pdf"
		done
		insinto /usr/share/doc/${PF}/manual
		doins * || die "failed to install manual files"
	fi
}
