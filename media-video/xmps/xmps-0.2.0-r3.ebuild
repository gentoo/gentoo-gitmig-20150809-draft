# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xmps/xmps-0.2.0-r3.ebuild,v 1.9 2007/07/12 02:40:42 mr_bones_ Exp $

inherit eutils

IUSE="nls"

DESCRIPTION="X Movie Player System"
SRC_URI="http://xmps.sourceforge.net/sources/${P}.tar.gz"
HOMEPAGE="http://xmps.sourceforge.net"

RDEPEND="=x11-libs/gtk+-1.2*
	x86? ( >=dev-lang/nasm-0.98 )
	>=dev-libs/popt-1.5
	>=media-libs/smpeg-0.4.4-r1
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}

	# Fixes compile issues on motion_comp.c (Bug #2822)
	cd ${S}
	epatch ${FILESDIR}/xmps-0.2.0_motion_comp.c.gentoo.diff
}

src_compile() {

	local myconf

	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die "econf failed"

	for file in `find . -iname "Makefile"`;do
		sed -i -e "s:-Werror::g;s:-ldb1:-ldb:g" \
			${file} || die "sed-fu failed"
	done

	sed -i -e "s:\(#ifdef HAVE_CONFIG_H\):#define _LIBC 1\n\1:" \
		intl/l10nflist.c || die "sed-fu 2 failed"

	sed -i -e "s:\$(bindir)/xmps-config:\$(DESTDIR)\$(bindir)/xmps-config:" \
		Makefile || die "sed-fu 3 failed"

	emake || die "emake failed"

}

src_install () {

	einstall || die "einstall failed"

	dodoc AUTHORS ChangeLog NEWS README TODO

}
