# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/fwbuilder/fwbuilder-1.1.2.ebuild,v 1.8 2004/04/21 16:19:18 vapier Exp $

inherit flag-o-matic

DESCRIPTION="A firewall GUI"
HOMEPAGE="http://www.fwbuilder.org/"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64 ~ppc"
IUSE="static nls"

DEPEND="sys-devel/autoconf
	=x11-libs/gtk+-1.2*
	>=media-libs/gdk-pixbuf-0.16.0
	=dev-cpp/gtkmm-1.2*
	=dev-libs/libsigc++-1.0*
	nls? ( >=sys-devel/gettext-0.11 )
	~net-libs/libfwbuilder-1.0.2"

src_compile() {
	use sparc && replace-flags -O3 -O2
	local myconf
	use static && myconf="${myconf} --enable-shared=no --enable-static=yes"
	use nls || myconf="${myconf} --disable-nls"

	./autogen.sh \
		--prefix=/usr \
		--host=${CHOST}	\
		${myconf} \
		|| die "./configure failed"

	sed -i -e "s:#define HAVE_XMLSAVEFORMATFILE 1://:" config.h

	if use static ; then
		emake LDFLAGS="-static" || die "emake LDFLAGS failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
}

pkg_postinst() {
	einfo "You need to emerge iproute2 on the machine that"
	einfo "will run the firewall script."
}
