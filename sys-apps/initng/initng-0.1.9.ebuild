# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/initng/initng-0.1.9.ebuild,v 1.1 2005/08/25 23:20:25 vapier Exp $

DESCRIPTION="A next generation init replacement"
HOMEPAGE="http://initng.thinktux.net/"
SRC_URI="http://initng.thinktux.net/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="debug"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/CFLAGS=.*ALL_CFLAGS/s|.*|:;|' \
		configure || die "sed configure"
	sed -i \
		-e "/^docdir/s:=.*:=/usr/share/doc/${PF}:" \
		doc/Makefile.in || die "sed Makefile"
}

src_compile() {
	econf \
		$(use_enable debug) \
		--prefix=/ || die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README FAQ AUTHORS ChangeLog NEWS TEMPLATE_HEADER TODO
}

pkg_postinst() {
	einfo "remember to add init=/sbin/initng in your grub or lilo config"
	einfo "to use initng Happy testing."
}
