# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/initng/initng-0.3.4.ebuild,v 1.1 2005/11/02 04:35:08 vapier Exp $

DESCRIPTION="A next generation init replacement"
HOMEPAGE="http://initng.thinktux.net/"
SRC_URI="http://initng.thinktux.net/download/v${PV:0:3}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="debug"

src_compile() {
	econf \
		$(use_enable debug) \
		--with-doc-dir=/usr/share/doc/${PF} \
		--prefix=/ \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	# Dont need libtool linker scripts, so punt em
	find "${D}" -name '*.la' -exec rm {} \;
	# other packages install these
	rm -f "${D}"/sbin/{ifplugd,wpa_cli}.action
	dodoc README FAQ AUTHORS ChangeLog NEWS TEMPLATE_HEADER TODO
}

pkg_postinst() {
	einfo "remember to add init=/sbin/initng in your grub or lilo config"
	einfo "to use initng Happy testing."
}
