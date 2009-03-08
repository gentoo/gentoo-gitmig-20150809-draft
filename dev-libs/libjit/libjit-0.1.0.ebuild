# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libjit/libjit-0.1.0.ebuild,v 1.4 2009/03/08 18:41:32 loki_val Exp $

inherit eutils

DESCRIPTION="Just-In-Time compilation functionality and is designed to be independent of any particular virtual machine bytecode format or language"
HOMEPAGE="http://www.southern-storm.com.au/libjit.html"
SRC_URI="http://www.southern-storm.com.au/download/${P}.tar.gz
		 http://download.savannah.gnu.org/releases/dotgnu-pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc examples interpreter long-double new-reg-alloc"

DEPEND="doc? ( app-text/texi2html )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PN}-0.1.2-gcc43.patch"

	# Upstream forgot a header fille, bug #190483
	cp ${FILESDIR}/${P}-jit-rules-interp.h ${S}/jit/jit-rules-interp.h
}

src_compile() {
	econf \
		$(use_enable interpreter) \
		$(use_enable long-double) \
		$(use_enable new-reg-alloc) \
		|| die "configure failed"

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
	dodoc AUTHORS ChangeLog NEWS README

	if use examples ; then
		docinto examples
		dodoc tutorial/{README,*.c}
	fi

	if use doc ; then
		docinto html
		dohtml libjit/*.html
	fi
}
