# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cacao/cacao-0.93.ebuild,v 1.2 2005/12/21 11:40:34 betelgeuse Exp $

inherit base eutils

DESCRIPTION="Cacao Java Virtual Machine"
HOMEPAGE="http://www.cacaojvm.org/"
SRC_URI="http://www.complang.tuwien.ac.at/cacaojvm/download/${P}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=">=dev-java/gnu-classpath-0.19"
DEPEND="dev-java/jikes
		${REPEND}"

PATCHES="${FILESDIR}/${PV}-no-exec-stack.patch"

src_compile() {
	# No way to force a compiler yet. Needs jikes atm.
	# http://b2.complang.tuwien.ac.at/cgi-bin/bugzilla/show_bug.cgi?id=13

	econf --bindir=/opt/${PN}/bin \
		--disable-dependency-tracking \
		--with-classpath-install-dir=/usr/

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodir /usr/bin
	dosym /opt/${PN}/bin/cacao /usr/bin/cacao
	dodoc AUTHORS ChangeLog* NEWS README TODO || die "failed to install docs"
}
