# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gerris/gerris-0.9.2.ebuild,v 1.4 2008/05/12 13:20:56 markusle Exp $

DESCRIPTION="The Gerris Flow Solver"
LICENSE="GPL-2"
HOMEPAGE="http://gfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/gfs/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc mpi dx"

RDEPEND=">=dev-libs/glib-2.4.0
		>=sci-libs/gts-0.7.4
		sys-apps/gawk
		dev-lang/python
		mpi? ( virtual/mpi )
		dx? ( sci-visualization/opendx )"
DEPEND="${RDEPEND}
		sys-devel/libtool"

src_compile() {
	# disable explicit building of tutorial
	sed -e "s:tutorial::" -i doc/Makefile.am || \
		die "failed to disable building of tutorial"
	sed -e "s:tutorial::" -i doc/Makefile.in || \
		die "failed to disable building of tutorial"

	econf $(use_enable mpi ) \
		$(use_enable dx) \
		|| die "configure failed"

	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO

	# extended documentation
	if use doc; then
		dohtml doc/html/*

		insinto /usr/share/doc/${P}/examples
		doins -r doc/examples/*

		insinto /usr/share/doc/${P}/tutorial
		doins doc/tutorial/tutorial.pdf

		insinto /usr/share/doc/${P}/faq
		doins doc/faq/faq.pdf
	fi
}
