# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mplinuxman/mplinuxman-1.5.ebuild,v 1.5 2008/05/17 09:22:04 drac Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Manager for MPMan F60/55/50 MP3 players."
HOMEPAGE="http://mplinuxman.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}-source-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	virtual/mpg123"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/${PN}

# This is ugly and someone should write upstream a patch,
# but it's not me. - drac
src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-stringh.patch

	sed -e "s:CFLAGS = :CFLAGS = ${CFLAGS} :" \
		-e 's:/usr/local/share/locale:$(DESTDIR)/usr/share/locale:' \
		-i makefile
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed."
	cd extra/mp_util
	emake CC="$(tc-getCC)" || die "emake failed."
}

src_install() {
	dobin ${PN} extra/mp_util/{mputil,mputil_smart}

	dodir /usr/share/locale/{de,es,fr,ja,nl}/LC_MESSAGES

	DESTDIR="${D}" emake install-po

	newicon logo.xpm ${PN}.xpm
	make_desktop_entry ${PN} ${PN} ${PN} "AudioVideo;Audio;GTK;"

	dodoc CHANGES README extra/mp_util/USAGE.txt
}
