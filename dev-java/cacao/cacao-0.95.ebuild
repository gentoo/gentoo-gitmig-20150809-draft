# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cacao/cacao-0.95.ebuild,v 1.3 2007/06/26 01:46:59 mr_bones_ Exp $

inherit eutils flag-o-matic

DESCRIPTION="Cacao Java Virtual Machine"
HOMEPAGE="http://www.cacaojvm.org/"
SRC_URI="http://www.complang.tuwien.ac.at/cacaojvm/download/${P}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=dev-java/gnu-classpath-0.19"
RDEPEND="${DEPEND}"

src_compile() {
	# Upstream has patches this already so we just use this until the next
	# version
	append-flags -Wa,--noexecstack

	# A compiler can be forced with the JAVAC variable if needed

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
