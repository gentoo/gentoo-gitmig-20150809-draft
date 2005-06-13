# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect/eselect-0.9.4.ebuild,v 1.1 2005/06/13 12:59:11 ka0ttic Exp $

inherit bash-completion

DESCRIPTION="Modular -config replacement utility"
HOMEPAGE="http://www.gentoo.org/proj/en/eselect/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~kugelfang/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND="doc? ( dev-python/docutils )"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
	if use doc ; then
		cd doc ; make html || die "failed to build html"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README doc/*.txt
	use doc && dohtml doc/*
	dobashcompletion misc/${PN}.bashcomp
}
