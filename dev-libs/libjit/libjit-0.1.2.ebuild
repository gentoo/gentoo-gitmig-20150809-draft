# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libjit/libjit-0.1.2.ebuild,v 1.1 2009/03/08 18:41:32 loki_val Exp $

EAPI=2

inherit eutils

DESCRIPTION="Libjit  is a generic Just-In-Time compilation library"
HOMEPAGE="http://www.gnu.org/software/dotgnu/"
SRC_URI="mirror://gnu/dotgnu/libjit/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc examples interpreter long-double new-reg-alloc"

DEPEND="doc? ( app-text/texi2html )"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${P}-gcc43.patch"
}
src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable interpreter) \
		$(use_enable long-double) \
		|| die "configure failed"
}

src_compile() {
	emake || die "emake failed"

	if use doc ; then
		if [ ! -f "${S}"/doc/libjit.texi ] ; then
			die "libjit.texi was not generated"
		fi

		texi2html -split_chapter "${S}"/doc/libjit.texi \
			|| die "texi2html failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"

	if use examples ; then
		docinto examples
		dodoc tutorial/{README,*.c} || die  "examples failed"
	fi

	if use doc ; then
		docinto html
		dohtml libjit/*.html || die "doc failed"
	fi

	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
