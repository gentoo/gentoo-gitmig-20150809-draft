# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/g15composer/g15composer-3.1.ebuild,v 1.6 2007/03/29 22:16:05 jokey Exp $

inherit eutils

DESCRIPTION="A library to render text and shapes into a buffer usable by the Logitech G15 keyboard"
HOMEPAGE="http://g15tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/g15tools/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="amarok truetype examples"

DEPEND="app-misc/g15daemon
	>=dev-libs/libg15render-1.2
	truetype? ( media-libs/freetype )
	amarok? ( kde-base/kdelibs )"

RDEPEND="${DEPEND}
	amarok? ( dev-perl/DCOP-Amarok-Player )"

pkg_setup() {
	local failure=false
	echo
	if use amarok && ! built_with_use dev-lang/perl ithreads ; then
		eerror "dev-lang/perl must be built with USE=\"ithreads\" for the Amarok display to work."
		failure=true
	fi
	if use truetype && ! built_with_use dev-libs/libg15render truetype ; then
		eerror "dev-libs/libg15render must be built with USE=\"truetype\" for truetype to work."
		failure=true
	fi
	if ${failure}; then
		die "Please rebuild the packages with corrected USE flags."
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
