# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/dvd95/dvd95-1.1_p1.ebuild,v 1.1 2006/12/03 05:20:29 pylon Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="DVD95 is a Gnome application to convert DVD9 to DVD5."
HOMEPAGE="http://dvd95.sourceforge.net/"
SRC_URI="mirror://sourceforge/dvd95/${MY_P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE_LINGUAS="linguas_en linguas_fr"
IUSE="${IUSE_LINGUAS} mmx 3dnow sse sse2"

DEPEND="gnome-base/libgnomeui
    media-libs/libdvdread"

RDEPEND="gnome-base/libgnomeui
    media-libs/libdvdread"

src_compile() {

	# This package provides en and fr for LINGUAS.
	# Default language is French, but switch to English if no LINGUAS is set.

	if [ -z "${LINGUAS}" ]; then
		export LINGUAS="en"
	fi

	econf $(use_enable mmx) \
		$(use_enable 3dnow) \
		$(use_enable sse) \
		$(use_enable sse2) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog COPYING NEWS README
}

