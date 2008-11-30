# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ppl/ppl-0.10.ebuild,v 1.1 2008/11/30 02:59:13 vapier Exp $

DESCRIPTION="The Parma Polyhedra Library (PPL) is a modern and reasonably complete library providing numerical abstractions especially targeted at applications in the field of analysis and verification of complex systems"
HOMEPAGE="http://www.cs.unipr.it/ppl/"
SRC_URI="http://www.cs.unipr.it/ppl/Download/ftp/releases/${PV}/${P}.tar.bz2
	ftp://ftp.cs.unipr.it/pub/ppl/releases/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86"
IUSE="prolog"

RDEPEND="prolog? ( dev-lang/swi-prolog )"
DEPEND="${RDEPEND}
	sys-devel/m4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/have_swi_prolog=/s:=.*:=$(use prolog && echo yes || echo no):" \
		-e '/^docdir=.${datadir}.doc.ppl./d' \
		configure
}

src_compile() {
	econf --docdir=/usr/share/doc/${PF} || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	cd /usr/share/doc/${PF}
	mkdir html
	mv *-html html/
	prepalldocs
}
