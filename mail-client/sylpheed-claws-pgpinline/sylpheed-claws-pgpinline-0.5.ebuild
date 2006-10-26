# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-pgpinline/sylpheed-claws-pgpinline-0.5.ebuild,v 1.12 2006/10/26 23:51:09 ticho Exp $

MY_P="${P##sylpheed-claws-}"

DESCRIPTION="Plugin for sylpheed-claws to support mails with inline pgp signatures"
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="http://claws.sylpheed.org/downloads/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 alpha ppc64"
IUSE=""
DEPEND="=mail-client/sylpheed-claws-1.0*
		=app-crypt/gpgme-0.3.14-r1
		dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_compile() {
	export GPGME_CONFIG=${ROOT}/usr/bin/gpgme3-config

	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README
}
