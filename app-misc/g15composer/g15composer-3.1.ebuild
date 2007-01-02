# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/g15composer/g15composer-3.1.ebuild,v 1.1 2007/01/02 03:42:21 rbu Exp $

inherit eutils

DESCRIPTION="A library to render text and shapes into a buffer usable by the Logitech G15 keyboard"
HOMEPAGE="http://g15tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/g15tools/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="amarok truetype examples"

DEPEND="app-misc/g15daemon
	>=dev-libs/libg15render-1.2
	truetype? ( media-libs/freetype )
	amarok? ( kde-base/kdelibs )"

RDEPEND="${DEPEND}
	amarok? ( dev-perl/DCOP-Amarok-Player )"

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

	newinitd "${FILESDIR}/${P}.initd" ${PN}
	newconfd "${FILESDIR}/${P}.confd" ${PN}

	dodoc AUTHORS README ChangeLog

	if use examples ; then
		exeinto "${ROOT}/usr/share/${PN}"
		doexe examples/*
	fi

	if use amarok ; then
		exeinto "${ROOT}/usr/share/apps/amarok/scripts"
		newexe examples/amarok-g15-perl.pl g15-display.pl
	fi
}

pkg_postinst() {
	einfo "Set the user to run g15composer in /etc/conf.d/g15composer before starting the service."

	if use amarok; then
		echo
		einfo "g15-display.pl was installed into your Amarok script directory."
		einfo "To start it, have a look at Tools -> Script Manager in the Amarok menu."
	fi
}
