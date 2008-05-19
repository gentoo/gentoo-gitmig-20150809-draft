# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/zzuf/zzuf-0.10.ebuild,v 1.2 2008/05/19 00:25:47 carlo Exp $

inherit autotools

DESCRIPTION="Transparent application input fuzzer"
HOMEPAGE="http://sam.zoy.org/zzuf/"
SRC_URI="http://sam.zoy.org/zzuf/${P}.tar.gz"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e '/CFLAGS/d' "${S}/configure.ac" \
		|| die "unable to fix the configure.ac"
	eautoreconf
}

src_compile() {
	# Don't build the static library, as the library is only used for
	# preloading, so there is no reason to build it statically, unless
	# you want to use zzuf with a static-linked executable, which I'm
	# not even sure would be a good idea.
	econf \
		--disable-dependency-tracking \
		--disable-static \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO

	find "${D}" -name '*.la' -delete
}
