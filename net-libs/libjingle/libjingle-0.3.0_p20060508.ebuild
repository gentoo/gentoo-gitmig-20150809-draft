# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libjingle/libjingle-0.3.0_p20060508.ebuild,v 1.4 2006/06/02 20:06:14 genstef Exp $

inherit autotools

DESCRIPTION="Google's jabber voice extension library modified by Tapioca"
HOMEPAGE="http://tapioca-voip.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~genstef/files/dist/${P}.tar.bz2"

LICENSE="BSD"
KEYWORDS="~x86"
IUSE="speex ilbc ortp"
SLOT="0"

RDEPEND="dev-libs/openssl
	!net-im/kopete
	ortp? (
		~net-libs/ortp-0.7.1
		ilbc? ( dev-libs/ilbc-rfc3951 )
		speex? ( media-libs/speex )
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	grep -rl "speex.h" . | xargs sed -i -e "s:speex.h:speex/\0:" || die
	grep -rl "iLBC_..code.h" . | xargs sed -i -e "s:iLBC_..code.h:ilbc/\0:" || die
	sed -i -e 's:scoped_ptr.h":\0\n#include <string>:' talk/base/xmpppassword.h || die
	sed -i -e "s:\(libjingle[^.]*\).la:\1-0.3.la:" talk/examples/*/Makefile.am || die
	sed -i "s:libmediastreamer_la_LIBADD.*:\0 \$(SPEEX_CFLAGS):" talk/third_party/mediastreamer/Makefile.am || die

	eautoreconf || die "eautoreconf failed"
	econf $(use_enable ortp linphone) \
		$(use_enable ortp) \
		$(use_with ilbc) \
		$(use_with speex) \
		--disable-examples || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
