# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkmm/gtkmm-1.2.9-r2.ebuild,v 1.17 2010/10/30 21:05:21 pacho Exp $

inherit eutils

DESCRIPTION="C++ interface for GTK+"
HOMEPAGE="http://www.gtkmm.org"
SRC_URI="http://download.sourceforge.net/gtkmm/${P}.tar.gz"
#	 ftp://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz
#	 http://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1.2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc sh sparc x86"
IUSE="debug"

DEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/libsigc++-1.0*"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# this patch applies only to gtkmm-1.2.9. gtkmm has been fixed
	# in CVS. It fixes a build problem with gcc3.1.
	# (http://marc.theaimsgroup.com/?l=gtkmm&m=101879848701486&w=2)
	epatch "${FILESDIR}"/gtkmm-1.2.9-gcc3.1-gentoo.patch
	epatch "${FILESDIR}"/gtkmm-1.2.9-gcc3.4-gentoo.patch
	epatch "${FILESDIR}"/gtkmm-1.2.9-gcc4.patch
	epatch "${FILESDIR}/gtkmm-1.2.9-gcc4.3.patch"
}

src_compile() {
	local myconf
	use debug \
		&& myconf="--enable-debug=yes" \
		|| myconf="--enable-debug=no"
	econf \
		--sysconfdir=/etc/X11 \
		--with-xinput=xfree \
		--with-x \
		${myconf} || die

	make || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
