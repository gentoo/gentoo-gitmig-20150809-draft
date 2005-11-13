# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pal/pal-0.3.5_pre1.ebuild,v 1.1 2005/11/13 16:07:31 port001 Exp $

inherit toolchain-funcs

DESCRIPTION="pal command-line calendar program"
HOMEPAGE="http://palcal.sourceforge.net/"
SRC_URI="http://palcal.sourceforge.net/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="ical"

DEPEND=">=dev-libs/glib-2.0
	sys-devel/gettext
	virtual/libc
	sys-libs/readline
	ical? ( dev-libs/libical )"

S="${WORKDIR}/${P}/src"

src_compile() {
	emake \
		CC=$(tc-getCC) \
		OPT="${CFLAGS}" \
		|| die "emake failed"

	if useq ical; then
		cd convert
		emake \
			CC=$(tc-getCC) \
			OPT="${CFLAGS}" \
			ical \
			|| die "emake failed"
	fi
}

src_install() {
	make DESTDIR="${D}" install-no-rm || die "make install failed"

	if useq ical; then
		cd convert
		make DESTDIR="${D}" ical-install || die "make ical-install failed"
	fi

	cd ${WORKDIR}/${P}

	dodoc ChangeLog
}

