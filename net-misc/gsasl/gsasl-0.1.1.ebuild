# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gsasl/gsasl-0.1.1.ebuild,v 1.1 2004/07/06 00:50:24 langthang Exp $

DESCRIPTION="The GNU SASL (Simple Authentication and Security Layer)"
HOMEPAGE="http://www.gnu.org/software/gsasl/"
UPST_SRC=$P.tar.gz
SRC_URI="ftp://alpha.gnu.org/pub/gnu/gsasl/${UPST_SRC}"
LICENSE="LGPL-2.1"
SLOT="0"
# TODO: check http://www.gnu.org/software/gsasl/#dependencies for more
# 	optional external libraries.
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="kerberos nls static"
DEPEND="virtual/libc
	=net-libs/libgsasl-${PV}
	nls? ( sys-devel/gettext )
	kerberos? ( virtual/krb5 )"

src_compile() {
	local myconf="--enable-client --enable-server"
	myconf="${myconf} $(use_enable kerberos gssapi)"
	myconf="${myconf} $(use_enable nls)"
	myconf="${myconf} $(use_enable static)"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall
	dodoc ABOUT-NLS AUTHORS COPYING COPYING.DOC ChangeLog NEWS README README-alpha THANKS
}
