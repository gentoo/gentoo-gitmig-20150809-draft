# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mtr/mtr-0.64.ebuild,v 1.2 2004/11/02 15:07:53 vapier Exp $

inherit eutils

DESCRIPTION="My TraceRoute. Excellent network diagnostic tool."
HOMEPAGE="http://www.bitwizard.nl/mtr/"
SRC_URI="ftp://ftp.bitwizard.nl/mtr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sparc ~x86"
IUSE="gtk gtk2"

DEPEND=">=sys-libs/ncurses-5.2
	gtk? ( !gtk2? ( =x11-libs/gtk+-1.2* )
		gtk2? ( >=x11-libs/gtk+-2* ) )"

src_compile() {
	local myconf
	use gtk || myconf="${myconf} --without-gtk"

	epatch ${FILESDIR}/mtr-ac-res_mkquery.patch
	autoconf

	econf ${myconf} \
		`use_enable gtk2` || die
	emake || die
}

src_install() {
	# this binary is universal. ie: it does both console and gtk.
	make DESTDIR=${D} sbindir=/usr/bin install || die

	fowners root:wheel /usr/bin/mtr
	fperms 4710 /usr/bin/mtr

	dodoc AUTHORS COPYING ChangeLog FORMATS NEWS README SECURITY TODO
}
