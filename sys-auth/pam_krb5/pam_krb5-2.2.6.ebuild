# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_krb5/pam_krb5-2.2.6.ebuild,v 1.3 2007/06/24 18:10:09 peper Exp $

inherit eutils rpm

RH_EXTRAVERSION=2

DESCRIPTION="pam_krb5 module, taken from fedora"
HOMEPAGE="http://fedora.redhat.com"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RH_EXTRAVERSION}.src.rpm"
LICENSE="LGPL-2"
SLOT="0"

KEYWORDS=""

DEPEND="virtual/krb5
	>=sys-libs/pam-0.78-r2"

S=${WORKDIR}/${P}-${RH_EXTRAVERSION}

src_compile() {
	export CFLAGS="${CFLAGS} -fPIC"
	econf --libdir=/lib || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README TODO
}
