# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libgsasl/libgsasl-0.2.0.ebuild,v 1.1 2004/11/13 13:44:24 slarti Exp $

DESCRIPTION="The GNU SASL library"
HOMEPAGE="http://www.gnu.org/software/gsasl/"
SRC_URI="ftp://alpha.gnu.org/pub/gnu/gsasl/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
# TODO: check http://www.gnu.org/software/gsasl/#dependencies for more
# 	optional external libraries.
# KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="kerberos nls static"
PROVIDE="virtual/gsasl"
DEPEND="virtual/libc
	nls? ( sys-devel/gettext )
	kerberos? ( virtual/krb5 )"
RDEPEND="${DEPEND}
	!virtual/gsasl"

src_compile() {
	econf \
		$(use_enable kerberos gssapi) \
		$(use_enable nls) \
		$(use_enable static) \
	|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc ABOUT-NLS AUTHORS ChangeLog NEWS README README-alpha THANKS
}
