# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/pekwm/pekwm-0.1.3-r2.ebuild,v 1.2 2003/09/04 07:41:11 msterret Exp $

IUSE=""

S="${WORKDIR}/${P}"

DESCRIPTION="A small window mananger based on aewm++"
HOMEPAGE="http://pekwm.pekdon.net/"
SRC_URI="http://pekwm.pekdon.net/files/source/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-util/pkgconfig
	virtual/x11
	perl? dev-libs/libpcre"

src_compile() {
	if pkg-config xft
	    then
		myconf="${myconf} --disable-xft"
	    else
		myconf="${myconf} --enable-xft"
	fi
	use perl \
		&& myconf="${myconf} --enable-pcre" \
		|| myconf="${myconf} --disable-pcre"
	econf \
	    --enable-xinerama \
	    --enable-harbour \
	    ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install

	cd ${S}
	dodoc docs/pekwmdocs.txt AUTHORS ChangeLog* INSTALL LICENSE README* NEWS ROADMAP TODO
}
