# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/g15composer/g15composer-3.1.ebuild,v 1.9 2009/08/15 12:42:57 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="A library to render text and shapes into a buffer usable by the Logitech G15 keyboard"
HOMEPAGE="http://g15tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/g15tools/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="amarok truetype examples"

DEPEND="app-misc/g15daemon
	>=dev-libs/libg15render-1.2[truetype?]
	truetype? ( media-libs/freetype )
	amarok? ( kde-base/kdelibs
		dev-lang/perl[ithreads] )"
RDEPEND="${DEPEND}
	amarok? ( dev-perl/DCOP-Amarok-Player )"

src_configure() {
	econf \
		$(use_enable truetype ttf)
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	newinitd "${FILESDIR}/${P}.initd" ${PN}
	newconfd "${FILESDIR}/${P}.confd" ${PN}

	dodoc AUTHORS README ChangeLog

	if use examples ; then
		exeinto "/usr/share/${PN}"
		doexe examples/*
	fi

	if use amarok ; then
		exeinto "/usr/share/apps/amarok/scripts"
		newexe examples/amarok-g15-perl.pl g15-display.pl
	fi
}

pkg_postinst() {
	elog "Set the user to run g15composer in /etc/conf.d/g15composer before starting the service."

	if use amarok; then
		echo
		elog "g15-display.pl was installed into your Amarok script directory."
		elog "To start it, have a look at Tools -> Script Manager in the Amarok menu."
	fi
}
