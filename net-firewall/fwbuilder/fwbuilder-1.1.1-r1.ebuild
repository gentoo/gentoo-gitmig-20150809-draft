# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/fwbuilder/fwbuilder-1.1.1-r1.ebuild,v 1.1 2004/02/09 05:38:32 nerdboy Exp $

DESCRIPTION="A firewall GUI"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"
HOMEPAGE="http://www.fwbuilder.org/"
RESTRICT="nomirror"
S=${WORKDIR}/${P}

KEYWORDS="~x86 ~sparc ~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE="static nls"

DEPEND="sys-devel/autoconf
	=x11-libs/gtk+-1.2*
	>=media-libs/gdk-pixbuf-0.16.0
	=dev-cpp/gtkmm-1.2*
	=dev-libs/libsigc++-1.0*
	nls? ( >=sys-devel/gettext-0.11 )
	~net-libs/libfwbuilder-1.0.2"

RDEPEND="sys-apps/iproute"

# Added by Jason Wever <weeve@gentoo.org>
# Fix for bug #30256.
if [ "${ARCH}" = "sparc" ]; then
	inherit flag-o-matic
	replace-flags "-O3" "-O2"
fi

src_compile() {
	local myconf
	myconf="--with-gnu-ld"
	use static	&&	myconf="${myconf} --enable-shared=no --enable-static=yes"
	use nls		||	myconf="${myconf} --disable-nls"

	cd ${S}

	env WANT_AUTOCONF_2_5=1 ./autogen.sh \
		--prefix=/usr \
		--host=${CHOST}	|| die "./autogen.sh failed"

	sed -i -e "s:#define HAVE_XMLSAVEFORMATFILE 1://:" config.h

	if [ "`use static`" ]
	then
		emake LDFLAGS="-static" || die "emake LDFLAGS failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
}

pkg_postinst() {
	einfo "You may have to install iproute on the machine that"
	einfo "will run the firewall script."
}

