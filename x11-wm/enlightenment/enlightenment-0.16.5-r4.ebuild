# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment/enlightenment-0.16.5-r4.ebuild,v 1.16 2003/06/09 09:30:27 hanno Exp $

DESCRIPTION="Enlightenment Window Manager"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"
HOMEPAGE="http://www.enlightenment.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="nls"

DEPEND=">=media-libs/fnlib-0.5
	esd? ( >=media-sound/esound-0.2.19 )
	~media-libs/freetype-1.3.1
	>=gnome-base/libghttp-1.0.9-r1"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use esd \
		&& soundconf="--enable-sound=yes" \
		|| soundconf="--enable-sound=no"
	econf \
		`use_enable nls` \
		--enable-fsstd \
		${soundconf} || die
	emake || die
}

src_install() {
	# this fixes an issue where enlightenment.install has an incomplete
	# path to the englightenment binary
	mv scripts/${PN}.install.in scripts/${PN}.install.in.orig
	sed 's:\(^EBIN=\).*:\1@prefix@/bin:' \
		scripts/${PN}.install.in.orig > scripts/${PN}.install.in

	make install DESTDIR=${D} || die

	dodoc ABOUT-NLS AUTHORS ChangeLog FAQ INSTALL NEWS README
	docinto sample-scripts
	dodoc sample-scripts/*

	exeinto /etc/X11/Sessions
	doexe $FILESDIR/enlightenment
}
