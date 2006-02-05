# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cacao/cacao-0.94.ebuild,v 1.1 2006/02/05 14:01:43 betelgeuse Exp $

inherit eutils flag-o-matic

DESCRIPTION="Cacao Java Virtual Machine"
HOMEPAGE="http://www.cacaojvm.org/"
SRC_URI="http://www.complang.tuwien.ac.at/cacaojvm/download/${P}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=">=dev-java/gnu-classpath-0.19"
DEPEND="dev-java/jikes
		${REPEND}"

src_compile() {
	# Upstream has patches this already so we just use this until the next 
	# version
	append-flags -Wa,--noexecstack

	# No way to force a compiler yet. Needs jikes atm.
	# http://b2.complang.tuwien.ac.at/cgi-bin/bugzilla/show_bug.cgi?id=13

	econf --bindir=/opt/${PN}/bin \
		--disable-dependency-tracking \
		--with-classpath-prefix=/usr/ \
		--with-classpath-libdir="/usr/$(get_libdir)"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodir /usr/bin
	dosym /opt/${PN}/bin/cacao /usr/bin/cacao
	dodoc AUTHORS ChangeLog* NEWS README || die "failed to install docs"
}
