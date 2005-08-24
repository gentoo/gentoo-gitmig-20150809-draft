# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect/eselect-0.9.6.ebuild,v 1.4 2005/08/24 23:12:20 vapier Exp $

DESCRIPTION="Modular -config replacement utility"
HOMEPAGE="http://www.gentoo.org/proj/en/eselect/"
SRC_URI="http://dev.gentoo.org/~kugelfang/${PN}/${P}.tar.bz2
	mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~s390 ~sh ~sparc ~x86"
IUSE="doc bash-completion"

DEPEND="sys-apps/sed
	doc? ( dev-python/docutils )"
RDEPEND="sys-apps/sed"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"

	if use doc ; then
		make html || die "failed to build html"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README TODO doc/*.txt
	use doc && dohtml *.html doc/*

	# we don't use bash-completion.eclass since eselect
	# is listed in RDEPEND.
	if use bash-completion ; then
		insinto /usr/share/bash-completion
		newins misc/${PN}.bashcomp ${PN} || die
	fi
}

pkg_postinst() {
	if use bash-completion ; then
		echo
		einfo
		einfo "To enable command-line completion for eselect, run:"
		einfo
		einfo "  eselect bashcomp enable eselect"
		einfo
		echo
	fi
}
