# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/g15composer/g15composer-3.0.2.ebuild,v 1.1 2006/12/06 19:52:39 jokey Exp $

inherit eutils

DESCRIPTION="A library to render text and shapes into a buffer usable by the Logitech G15 keyboard"
HOMEPAGE="http://g15tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/g15tools/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="amarok truetype"

RDEPEND="app-misc/g15daemon
	dev-libs/libg15render
	truetype? ( media-libs/freetype )
	amarok? ( kde-base/kdelibs  dev-perl/DCOP-Amarok-Player )"

DEPEND="${RDEPEND}
	dev-libs/libg15"

pkg_setup() {
	if use amarok && ! built_with_use dev-lang/perl ithreads ; then
		echo
		eerror "dev-lang/perl must be built with USE=\"ithreads\" for the Amarok display to work."
		die
	fi
}

src_compile() {
	econf \
		$(use_enable truetype ttf ) \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	newinitd "${FILESDIR}/${PN}-2.1.initd" ${PN}
	newconfd "${FILESDIR}/${PN}-2.1.confd" ${PN}

	dodoc AUTHORS README ChangeLog

	exeinto "${ROOT}usr/share/${PN}"
	doexe examples/*

	if use amarok ; then
		exeinto "${ROOT}usr/share/apps/amarok/scripts"
		newexe examples/amarok-g15-perl.pl g15-display.pl
	fi
}

pkg_postinst() {
	if use amarok; then
		einfo "g15-display.pl was installed into your Amarok script directory."
		einfo "To start it, have a look at Tools -> Script Manager in the Amarok menu."
	fi
}
